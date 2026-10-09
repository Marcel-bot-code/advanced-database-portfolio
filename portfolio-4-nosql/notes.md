# Portfolio 4 – NoSQL with MongoDB (OCNS)

Database `ocns` on MongoDB Atlas (free M0 cluster). Code: [mongo_commands.js](mongo_commands.js)
The same 10 fictional students as the SQL database, stored as documents.

## Document design

```js
{
  _id: "OCNS/BN/2025/002",            // matric number is the key
  name: "Chinedu Adeyemi",
  level: 200,
  programme: "Basic Nursing",          // copied in (denormalised) – no JOIN needed
  department: "General Nursing",
  session: "2025/2026",
  courses: [                           // EMBEDDED: registrations + scores
    { code: "NUR105", title: "Pharmacology for Nurses", units: 3, ca: 36.5, exam: 21.3, score: 57.8 },
    { code: "NUR106", title: "Community Health Nursing I", units: 2, ca: 15.7, exam: 53.2, score: 68.9 }
  ],
  clinical_postings: [ { hospital: "Riverside General Hospital", ward: "Accident & Emergency", start: "2026-06-01" } ],
  next_of_kin: { name: "Mrs. Adeyemi", phone: "0800 000 0002" }   // only some students have this
}
```
Payments are a **separate** `payments` collection: `{ student_id: "OCNS/BN/2025/002", amount: 281500, paystack_ref: "…" }`.

## What I ran (screenshots below)

| # | Command | Result |
|---|---|---|
| 1 | `insertMany` – 10 students, 10 payments | `acknowledged: true`, 10 ids each |
| 2 | `find({ programme: "Basic Nursing" })` | 3 students: Amaka Okafor, Chinedu Adeyemi, Hauwa Lawal |
| 2b | `find({ "courses.code": "NUR101" })` – searching **inside** the embedded array | 4 students |
| 3 | `aggregate` `$unwind` + `$group` – average score per course | 12 courses, highest GST101 (77.0), lowest MID101 (38.5) |
| 3b | `aggregate` `$lookup` – total paid per student | Chinedu Adeyemi top with ₦493,000; 2 students have paid nothing |
| 4 | `createIndex({ name: 1 })` then `explain()` | winning plan changes from `COLLSCAN` to `IXSCAN` |

<!-- Screenshots: insert.png, find.png, aggregate.png, index.png -->

## Embed or reference?

I **embedded** a student's courses and scores, clinical postings and next of kin, because they belong to one student only, they are small, and they are almost always read together – opening a student's record in one read with no JOINs is exactly what the results and posting screens need. I **kept payments in a separate collection and referenced** the student by matric number, because payments keep growing every session, the Bursary often works on payments across many students at once (daily reconciliation, Paystack exports), and money needs its own careful handling rather than being buried inside a large student document. I also copied the programme and department names into each student (denormalising) – this speeds up reads, at the cost of updating many documents if a programme is ever renamed.

## When MongoDB suits OCNS – and when it doesn't

MongoDB suits the parts of OCNS where records vary and speed of reading matters: the clinical posting log (each hospital and ward records different procedures and observations), student portfolios and uploaded documents, the e-learning activity history, and a fast "my record" page that fetches a whole student in one read. The flexible schema also means a new field, such as the NYSC details or a new procedure checklist, can be added without changing every record. It does not suit fees, payments and official results, where every naira and every grade must be exact and several records must change together: the relational model with foreign keys, CHECK rules and ACID transactions (Portfolio 3) is safer there. MongoDB does have multi-document transactions now, but SQL enforces these rules by design, so OCNS should keep money and results in MySQL and use MongoDB alongside it.

## Other NoSQL types (one line each)

- **Key-value (Redis):** stores a value under a key in memory, ideal for login sessions or caching the CBT question paper during an exam.
- **Wide-column (Cassandra):** spreads huge write-heavy tables across many servers, suited to logging every click or CBT answer at national scale.
- **Graph (Neo4j):** stores relationships as first-class data, useful for prerequisite chains between courses or tracing who supervised whom on which posting.
