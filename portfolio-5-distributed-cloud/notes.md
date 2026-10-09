# Portfolio 5 – Distributed & Cloud Databases (OCNS)

Code: [replication_commands.js](replication_commands.js)
Practical evidence comes from the free MongoDB Atlas M0 cluster used in Portfolio 4, which Atlas runs as a **3-server replica set** (one PRIMARY, two SECONDARY).

<!-- Screenshots: atlas_overview.png (PRIMARY/SECONDARY nodes), db_hello.png (or rs_status.png), failover.png if done -->

## Replication – what if the primary crashes during exams?

In a replica set every write goes to the PRIMARY and is copied to the two SECONDARY servers. If the primary crashes in the middle of a CBT exam, the secondaries notice within seconds that it has stopped answering, hold an election, and one of them becomes the new primary; the exam application reconnects automatically and students carry on, losing at most the answer they were saving at that moment. Writing answers with `writeConcern: "majority"` makes sure every confirmed answer is already on at least two servers, so a crash cannot wipe out answers that were already confirmed. Reports such as score sheets can also be read from a secondary, so they do not slow down the exam.

## Sharding – if OCNS grows to many campuses

Sharding splits one big collection across several servers, using a **shard key** to decide which server holds each record. For OCNS I would shard student, registration and payment data by **campus** (for example Port Harcourt, Abuja and future campuses), combined with matric number – `{ campus: 1, matric_no: 1 }`. Almost every query a campus runs is about its own students, so each query goes to one shard only; each campus can have its shard close to it; and a new campus simply adds a new shard. Sharding by session alone would be a poor key, because every write in a semester would land on the newest session's shard and overload it.

## CAP theorem – consistency or availability?

During a network split a distributed database must choose between staying **consistent** (refusing some requests) and staying **available** (answering, even with data that may be out of date). For results, fees and payments OCNS should choose **consistency**: a student must never see a wrong balance or a grade that another server has already changed, and the Bursary must never credit the same Paystack payment twice – a short "please try again" is far better than wrong money or wrong grades. For less critical features, such as the e-learning activity feed, notice board or clinical log drafts, availability is the better choice, because a slightly old view does no harm and students can keep working.

## Cloud or on-premise for a Nigerian college?

| | Cloud (e.g. Atlas, AWS, Azure) | On-premise (server in the college) |
|---|---|---|
| **Cost** | no hardware to buy; pay monthly in dollars, so exposed to exchange-rate changes | big upfront cost for server, UPS, inverter/solar and diesel, plus staff to run it |
| **Power** | runs in data centres with 24/7 power | needs inverter, batteries and generator to survive grid outages |
| **Backups** | automatic, copied to other regions; one click to restore | must be done by staff, and the copies are often in the same building |
| **Access** | students, staff and other campuses can use it from anywhere with data | works on the campus network even when the internet is down |
| **Internet** | unreachable during an internet outage at the college | not affected by the college's internet |

**My recommendation:** a **hybrid**. Keep the main database in the cloud, because reliable power, automatic backups, and access for students at home, on clinical posting and across campuses are what OCNS needs most. Add a small local server or offline mode for CBT exams on campus, which syncs back to the cloud afterwards, so an internet outage on exam day does not stop the exam.
