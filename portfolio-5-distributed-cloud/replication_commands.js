// =============================================================
//  OCNS – Portfolio 5: replication_commands.js
//  Run in mongosh connected to the Atlas M0 cluster (a 3-node replica set).
// =============================================================

// 1. Who is primary, who are the secondaries? (works on the free tier)
db.hello()
//    look for: setName, isWritablePrimary: true, hosts: [ 3 servers ], primary: "..."

// 2. Full replica-set status (may need a paid tier – if "not authorized",
//    use db.hello() above plus the Atlas Overview/Metrics screenshot)
rs.status().members.map(m => ({ name: m.name, state: m.stateStr, health: m.health }))

// 3. Write with majority acknowledgement: the write is only confirmed
//    once at least 2 of the 3 servers have it – it survives a primary crash.
use ocns
db.payments.insertOne(
  { student_id: "OCNS/MW/2025/015", amount: 140750, date: "2026-10-10",
    paystack_ref: "OCNSDEMO-RS-0001", session: "2025/2026" },
  { writeConcern: { w: "majority", wtimeout: 5000 } }
)

// 4. Read from a secondary (e.g. for reports, to take load off the primary)
db.getMongo().setReadPref("secondaryPreferred")
db.students.countDocuments()
db.getMongo().setReadPref("primary")

// 5. Failover test (Atlas UI): Cluster → "..." → Test Resilience → Test Primary Failover.
//    Then run db.hello() again: a different server is now primary,
//    and the data is all still there.
db.hello().primary
db.students.countDocuments()
