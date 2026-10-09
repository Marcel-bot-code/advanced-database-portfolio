// =============================================================
//  OCNS – Portfolio 4: mongo_commands.js
//  MIT 8103 Advanced Database Systems
//  Paste into the mongosh shell in MongoDB Atlas (Connect → Shell,
//  or Data Explorer → ">_ Open MongoDB Shell"), one block at a time.
//  Same 10 fictional students as the SQL database in Portfolio 1.
// =============================================================

use ocns

// Start clean so the script can be re-run
db.students.drop()
db.payments.drop()

// -------------------------------------------------------------
// 1. INSERT – one document per student.
//    EMBEDDED: courses + scores, clinical postings, next of kin
//    (they belong to one student and are always read with them).
//    Note the documents do NOT all have the same fields –
//    only some students have clinical_postings or next_of_kin.
// -------------------------------------------------------------
db.students.insertMany([
  {
    "_id": "OCNS/BN/2025/001",
    "name": "Amaka Okafor",
    "level": 100,
    "programme": "Basic Nursing",
    "department": "General Nursing",
    "session": "2025/2026",
    "courses": [
      {
        "code": "GST102",
        "title": "Computer Applications",
        "units": 2,
        "ca": 27.5,
        "exam": 41.8,
        "score": 69.3
      },
      {
        "code": "NUR104",
        "title": "Medical-Surgical Nursing I",
        "units": 3,
        "ca": 37.1,
        "exam": 17.5,
        "score": 54.6
      },
      {
        "code": "NUR201",
        "title": "Mental Health Nursing",
        "units": 3,
        "ca": 24.2,
        "exam": 25.4,
        "score": 49.6
      }
    ],
    "clinical_postings": [
      {
        "hospital": "Riverside General Hospital",
        "ward": "Antenatal Clinic",
        "start": "2026-02-02"
      }
    ]
  },
  {
    "_id": "OCNS/BN/2025/002",
    "name": "Chinedu Adeyemi",
    "level": 200,
    "programme": "Basic Nursing",
    "department": "General Nursing",
    "session": "2025/2026",
    "courses": [
      {
        "code": "NUR105",
        "title": "Pharmacology for Nurses",
        "units": 3,
        "ca": 36.5,
        "exam": 21.3,
        "score": 57.8
      },
      {
        "code": "NUR106",
        "title": "Community Health Nursing I",
        "units": 2,
        "ca": 15.7,
        "exam": 53.2,
        "score": 68.9
      }
    ],
    "clinical_postings": [
      {
        "hospital": "Riverside General Hospital",
        "ward": "Accident & Emergency",
        "start": "2026-06-01"
      }
    ],
    "next_of_kin": {
      "name": "Mrs. Adeyemi",
      "phone": "0800 000 0002"
    }
  },
  {
    "_id": "OCNS/BN/2025/007",
    "name": "Hauwa Lawal",
    "level": 100,
    "programme": "Basic Nursing",
    "department": "General Nursing",
    "session": "2025/2026",
    "courses": [
      {
        "code": "GST101",
        "title": "Use of English",
        "units": 2,
        "ca": 33.4,
        "exam": 43.6,
        "score": 77.0
      },
      {
        "code": "NUR105",
        "title": "Pharmacology for Nurses",
        "units": 3,
        "ca": 33.4,
        "exam": 57.1,
        "score": 90.5
      },
      {
        "code": "NUR201",
        "title": "Mental Health Nursing",
        "units": 3,
        "ca": 11.4,
        "exam": 22.0,
        "score": 33.4
      }
    ]
  },
  {
    "_id": "OCNS/ND/2025/009",
    "name": "Joy Essien",
    "level": 200,
    "programme": "ND Nursing",
    "department": "General Nursing",
    "session": "2025/2026",
    "courses": [
      {
        "code": "GST102",
        "title": "Computer Applications",
        "units": 2,
        "ca": 30.0,
        "exam": 32.2,
        "score": 62.2
      },
      {
        "code": "NUR106",
        "title": "Community Health Nursing I",
        "units": 2,
        "ca": 14.6,
        "exam": 46.8,
        "score": 61.4
      },
      {
        "code": "NUR201",
        "title": "Mental Health Nursing",
        "units": 3,
        "ca": 21.5,
        "exam": 32.5,
        "score": 54.0
      }
    ],
    "clinical_postings": [
      {
        "hospital": "Riverside General Hospital",
        "ward": "Antenatal Clinic",
        "start": "2026-05-04"
      }
    ]
  },
  {
    "_id": "OCNS/ND/2025/011",
    "name": "Lucky Asuquo",
    "level": 200,
    "programme": "ND Nursing",
    "department": "General Nursing",
    "session": "2025/2026",
    "courses": [
      {
        "code": "NUR101",
        "title": "Anatomy and Physiology I",
        "units": 3,
        "ca": 34.4,
        "exam": 56.2,
        "score": 90.6
      },
      {
        "code": "NUR102",
        "title": "Fundamentals of Nursing I",
        "units": 3,
        "ca": 25.0,
        "exam": 22.5,
        "score": 47.5
      },
      {
        "code": "NUR105",
        "title": "Pharmacology for Nurses",
        "units": 3,
        "ca": 15.7,
        "exam": 40.5,
        "score": 56.2
      }
    ],
    "clinical_postings": [
      {
        "hospital": "Riverside General Hospital",
        "ward": "Paediatrics",
        "start": "2026-05-04"
      }
    ]
  },
  {
    "_id": "OCNS/MW/2025/013",
    "name": "Nnamdi Umeh",
    "level": 100,
    "programme": "Post-Basic Midwifery",
    "department": "Midwifery",
    "session": "2025/2026",
    "courses": [
      {
        "code": "GST102",
        "title": "Computer Applications",
        "units": 2,
        "ca": 32.1,
        "exam": 17.5,
        "score": 49.6
      },
      {
        "code": "MID101",
        "title": "Foundations of Midwifery",
        "units": 3,
        "ca": 21.4,
        "exam": 17.5,
        "score": 38.9
      },
      {
        "code": "MID102",
        "title": "Antenatal Care",
        "units": 3,
        "ca": 21.2,
        "exam": 55.2,
        "score": 76.4
      }
    ],
    "clinical_postings": [
      {
        "hospital": "Oasis Community Health Centre",
        "ward": "Labour Ward",
        "start": "2026-05-04"
      }
    ],
    "next_of_kin": {
      "name": "Mrs. Umeh",
      "phone": "0800 000 0013"
    }
  },
  {
    "_id": "OCNS/MW/2025/015",
    "name": "Precious Inyang",
    "level": 100,
    "programme": "Post-Basic Midwifery",
    "department": "Midwifery",
    "session": "2025/2026",
    "courses": [
      {
        "code": "GST102",
        "title": "Computer Applications",
        "units": 2,
        "ca": 24.3,
        "exam": 23.7,
        "score": 48.0
      },
      {
        "code": "MID101",
        "title": "Foundations of Midwifery",
        "units": 3,
        "ca": 13.8,
        "exam": 24.3,
        "score": 38.1
      },
      {
        "code": "MID103",
        "title": "Neonatal Care",
        "units": 2,
        "ca": 31.8,
        "exam": 39.8,
        "score": 71.6
      }
    ],
    "clinical_postings": [
      {
        "hospital": "Oasis Community Health Centre",
        "ward": "Female Medical",
        "start": "2026-05-04"
      }
    ]
  },
  {
    "_id": "OCNS/CH/2025/016",
    "name": "Rita Chukwu",
    "level": 100,
    "programme": "Community Health Nursing",
    "department": "General Nursing",
    "session": "2025/2026",
    "courses": [
      {
        "code": "NUR101",
        "title": "Anatomy and Physiology I",
        "units": 3,
        "ca": 12.4,
        "exam": 36.7,
        "score": 49.1
      },
      {
        "code": "NUR103",
        "title": "Introduction to Microbiology",
        "units": 2,
        "ca": 24.1,
        "exam": 32.5,
        "score": 56.6
      }
    ],
    "clinical_postings": [
      {
        "hospital": "Oasis Community Health Centre",
        "ward": "Accident & Emergency",
        "start": "2026-05-04"
      }
    ]
  },
  {
    "_id": "OCNS/CH/2025/018",
    "name": "Tobi Ade",
    "level": 300,
    "programme": "Community Health Nursing",
    "department": "General Nursing",
    "session": "2025/2026",
    "courses": [
      {
        "code": "NUR101",
        "title": "Anatomy and Physiology I",
        "units": 3,
        "ca": 21.0,
        "exam": 31.8,
        "score": 52.8
      },
      {
        "code": "NUR105",
        "title": "Pharmacology for Nurses",
        "units": 3,
        "ca": 19.0,
        "exam": 17.5,
        "score": 36.5
      }
    ],
    "clinical_postings": [
      {
        "hospital": "Oasis Community Health Centre",
        "ward": "Antenatal Clinic",
        "start": "2026-05-04"
      }
    ]
  },
  {
    "_id": "OCNS/PN/2025/019",
    "name": "Uche Onyema",
    "level": 100,
    "programme": "Pre-Nursing Science Foundation",
    "department": "Basic Medical Sciences",
    "session": "2025/2026",
    "courses": [
      {
        "code": "GST102",
        "title": "Computer Applications",
        "units": 2,
        "ca": 16.9,
        "exam": 43.6,
        "score": 60.5
      },
      {
        "code": "NUR101",
        "title": "Anatomy and Physiology I",
        "units": 3,
        "ca": 38.5,
        "exam": 46.6,
        "score": 85.1
      },
      {
        "code": "NUR103",
        "title": "Introduction to Microbiology",
        "units": 2,
        "ca": 33.9,
        "exam": 33.8,
        "score": 67.7
      }
    ]
  }
])

// -------------------------------------------------------------
// 2. REFERENCED: payments live in their own collection and point
//    to the student by _id (matric number), like a foreign key.
// -------------------------------------------------------------
db.payments.insertMany([
  {
    "student_id": "OCNS/BN/2025/001",
    "amount": 10000.0,
    "date": "2025-10-06",
    "paystack_ref": "OCNSDEMO-100037",
    "session": "2025/2026"
  },
  {
    "student_id": "OCNS/BN/2025/002",
    "amount": 246500.0,
    "date": "2026-03-16",
    "paystack_ref": "OCNSDEMO-100074",
    "session": "2025/2026"
  },
  {
    "student_id": "OCNS/BN/2025/007",
    "amount": 10000.0,
    "date": "2026-01-19",
    "paystack_ref": "OCNSDEMO-100259",
    "session": "2025/2026"
  },
  {
    "student_id": "OCNS/ND/2025/009",
    "amount": 246500.0,
    "date": "2025-11-03",
    "paystack_ref": "OCNSDEMO-100333",
    "session": "2025/2026"
  },
  {
    "student_id": "OCNS/ND/2025/011",
    "amount": 12000.0,
    "date": "2025-10-13",
    "paystack_ref": "OCNSDEMO-100407",
    "session": "2025/2026"
  },
  {
    "student_id": "OCNS/MW/2025/013",
    "amount": 10000.0,
    "date": "2025-10-06",
    "paystack_ref": "OCNSDEMO-100444",
    "session": "2025/2026"
  },
  {
    "student_id": "OCNS/CH/2025/016",
    "amount": 12000.0,
    "date": "2026-01-19",
    "paystack_ref": "OCNSDEMO-100518",
    "session": "2025/2026"
  },
  {
    "student_id": "OCNS/CH/2025/018",
    "amount": 12000.0,
    "date": "2025-11-03",
    "paystack_ref": "OCNSDEMO-100592",
    "session": "2025/2026"
  },
  {
    "student_id": "OCNS/BN/2025/001",
    "amount": 10000.0,
    "date": "2026-01-19",
    "paystack_ref": "OCNSDEMO-100629",
    "session": "2025/2026"
  },
  {
    "student_id": "OCNS/BN/2025/002",
    "amount": 246500.0,
    "date": "2026-04-20",
    "paystack_ref": "OCNSDEMO-100666",
    "session": "2025/2026"
  }
])

// -------------------------------------------------------------
// 3. FIND – students on the Basic Nursing programme, names only
// -------------------------------------------------------------
db.students.find(
  { programme: "Basic Nursing" },
  { _id: 1, name: 1, programme: 1, level: 1 }
).sort({ name: 1 })

// 3b. FIND inside the embedded array – who took NUR101?
db.students.find(
  { "courses.code": "NUR101" },
  { name: 1, "courses.$": 1 }
)

// -------------------------------------------------------------
// 4. AGGREGATE – average score per course (the SQL GROUP BY)
// -------------------------------------------------------------
db.students.aggregate([
  { $unwind: "$courses" },
  { $group: {
      _id: "$courses.code",
      title:    { $first: "$courses.title" },
      students: { $sum: 1 },
      avg:      { $avg: "$courses.score" }
  } },
  { $project: { title: 1, students: 1, avg: { $round: ["$avg", 1] } } },
  { $sort: { avg: -1 } }
])

// 4b. AGGREGATE with $lookup – total paid per student (the SQL JOIN)
db.students.aggregate([
  { $lookup: { from: "payments", localField: "_id",
                foreignField: "student_id", as: "pays" } },
  { $project: { name: 1, total_paid: { $sum: "$pays.amount" },
                 payments: { $size: "$pays" } } },
  { $sort: { total_paid: -1 } }
])

// -------------------------------------------------------------
// 5. INDEX – speed up searches by name
// -------------------------------------------------------------
db.students.find({ name: "Hauwa Lawal" }).explain("executionStats").queryPlanner.winningPlan   // before: COLLSCAN
db.students.createIndex({ name: 1 })
db.students.getIndexes()
db.students.find({ name: "Hauwa Lawal" }).explain("executionStats").queryPlanner.winningPlan   // after: IXSCAN
