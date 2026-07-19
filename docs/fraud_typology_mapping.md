**ATO (Account Takeover)**

No single signal is reliable — requires corroborating combination
Contributing signals: device/DeviceInfo change, address or email domain change, transaction occurring after a change event, established account with a prior pattern that suddenly shifts
Honest limitation: genuine accounts of any age can be ATO victims — age is not a filter

**Identity Theft**

Contributing signals: new/young account indicators (D1 as an unofficial proxy, caveated), fast movement from account creation to transaction/credit request, name/address mismatch signals (M-columns)
Honest limitation: D1 interpretation is community-inferred, not officially documented

**Unauthorized Scam (stolen/skimmed card)**

Contributing signals: sudden first-time use on unfamiliar device/location, no gradual buildup or prior history, geographic distance (dist1/dist2) from usual pattern
Honest limitation: authorized scams (customer manipulated into transferring money themselves) are not detectable from this dataset — no behavioral or device anomaly exists, since the real customer knowingly transacts

Card Testing (worth adding — you flagged this earlier from FinGuard and it's IEEE-CIS relevant)

Contributing signals: high daily_velocity, low TransactionAmt values clustered close together in time, same card across many rapid attempts
