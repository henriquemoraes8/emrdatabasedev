RecordType.destroy_all

t = RecordType.create(name: "Medical Data")
RecordType.create(name: "Typed Notes", parent_id: t.id)
RecordType.create(name: "Handwritten Notes", parent_id: t.id)
RecordType.create(name: "Medications", parent_id: t.id)
RecordType.create(name: "History & Physical", parent_id: t.id)
RecordType.create(name: "X-ray", parent_id: t.id)
RecordType.create(name: "EKG", parent_id: t.id)
RecordType.create(name: "CCD", parent_id: t.id)

RecordType.create(name: "Signed Consent Form")
RecordType.create(name: "Referral")
RecordType.create(name: "Other")