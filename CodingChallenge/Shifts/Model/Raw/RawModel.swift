import Foundation

public enum Raw {
    // MARK: - Shifts
    public struct Shifts: Codable {
        let data: [Datum]
        let links: [String]
        let meta: Meta

        enum CodingKeys: String, CodingKey {
            case data = "data"
            case links = "links"
            case meta = "meta"
        }
    }

    // MARK: - Datum
    struct Datum: Codable {
        let date: String
        let shifts: [Shift]

        enum CodingKeys: String, CodingKey {
            case date = "date"
            case shifts = "shifts"
        }
    }

    // MARK: - Shift
    public struct Shift: Codable {
        let shiftID: Int
        let startTime: Date
        let endTime: Date
        let normalizedStartDateTime: String
        let normalizedEndDateTime: String
        let timezone: String
        let premiumRate: Bool
        let covid: Bool
        let shiftKind: String
        let withinDistance: Int
        let facilityType: FacilityType
        let skill: FacilityType
        let localizedSpecialty: LocalizedSpecialty

        enum CodingKeys: String, CodingKey {
            case shiftID = "shift_id"
            case startTime = "start_time"
            case endTime = "end_time"
            case normalizedStartDateTime = "normalized_start_date_time"
            case normalizedEndDateTime = "normalized_end_date_time"
            case timezone = "timezone"
            case premiumRate = "premium_rate"
            case covid = "covid"
            case shiftKind = "shift_kind"
            case withinDistance = "within_distance"
            case facilityType = "facility_type"
            case skill = "skill"
            case localizedSpecialty = "localized_specialty"
        }
    }

    // MARK: - FacilityType
    struct FacilityType: Codable {
        let id: Int
        let name: String
        let color: String

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case color = "color"
        }
    }

    // MARK: - LocalizedSpecialty
    struct LocalizedSpecialty: Codable {
        let id: Int
        let specialtyID: Int
        let stateID: Int
        let name: String
        let abbreviation: String
        let specialty: Specialty

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case specialtyID = "specialty_id"
            case stateID = "state_id"
            case name = "name"
            case abbreviation = "abbreviation"
            case specialty = "specialty"
        }
    }

    // MARK: - Specialty
    struct Specialty: Codable {
        let id: Int
        let name: String
        let color: String
        let abbreviation: String

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case color = "color"
            case abbreviation = "abbreviation"
        }
    }

    // MARK: - Meta
    struct Meta: Codable {
        let lat: Double
        let lng: Double

        enum CodingKeys: String, CodingKey {
            case lat = "lat"
            case lng = "lng"
        }
    }
}
