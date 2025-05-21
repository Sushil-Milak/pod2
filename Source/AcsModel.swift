//
//  RoomModel.swift
//  voice_video_version1
//
//  sushil. Need model
//
import Foundation

class UserModel: ObservableObject {
    @Published var token : String = ""
    @Published var acsUserId : String = ""
    @Published var roomId : String = ""
    
    
    @Published var age: Int = 0
}



// TODO: Model for FCM
struct Payload: Decodable {
    let aps: APS
    let roomToken: String?
    let chatToken: String?
    
}

struct APS: Decodable {
    let fcwAlert: FCWAlert
    let badge: Int?
}

struct FCWAlert: Decodable {
    let title: String
    let body: String?
    let action: String?
}

struct CreateRoom: Codable {
    let status: Int // Int?
    let message: String
    let data: Createroomdata
    //let result: CreateRoomResult
}

struct CreateRoomNonPush: Codable {
    let status: Int // Int?
    let message: String
    let result: CreateRoomResult
}
struct CreateRoomResult: Codable {
    let requestid : String
    let placeinqueue : String
    let sessionid : String
    let mobileid : String?
    let meetinginfo : Meetinginfo
    
}

struct Meetinginfo : Codable {
    let userData : [UserData2]
    let roomData : RoomData2
    let threadData : ThreadData2
    
}
struct userData: Codable {
    
    let id: ID
    let role: String
      let data: UserParticipantData
    
}
struct UserParticipantData: Codable {
    let token: String
    let expiresOn: String
}


struct UserData2 : Codable {
    let id : ID2
    let role : String
    let token : String
    let expiresOn : String

}

struct ID: Codable {
  
    let communicationUserId: String
    
}
struct ID2 : Codable,Hashable {
    let communicationUserId : String
    

}

struct RoomData2 : Codable {
    let createdOn : String
    let id : String
    let validFrom : String
    let validUntil : String
    let pstnDialOutEnabled : Bool
   

}

struct ThreadData2 : Codable {
    let chatThread : ChatThread
    
}

struct ChatThread : Codable {
    let id : String
    let topic : String
    let createdOn : String
    let createdBy : CreatedBy2
   
}
struct CreatedBy2 : Codable {
    let kind : String
    let communicationUserId : String
    
}







//what is Guest

struct CreateEncounterRequest: Codable {
    let status: Int // Int?
    let message: String
    let result: CreateEncounterRequestData
}

struct NonPushEncounterRequest: Codable {
   
    let requestId: String
    
    init(requestId: String)
    {
        self.requestId = requestId
    }
}

struct encounterRequest: Codable {
    let requestApp:String
    let requestMobileId: String
    let requestName: String
    let requestDesc: String
    let requestClientType: String
    let requestFirebaseProjectId:String
    
    init(requestApp: String, requestMobileId: String, requestName: String, requestDesc: String, requestClientType: String, requestFirebaseProjectId:String)
    {
        self.requestApp = requestApp
        self.requestMobileId = requestMobileId
        self.requestName = requestName
        self.requestDesc = requestDesc
        self.requestClientType = requestClientType
        self.requestFirebaseProjectId = requestFirebaseProjectId
    }
}


struct Guest: Codable {
    let name: String
    let email: String
    init(name: String, email: String)
    {
        self.name = name
        self.email = email
    }
}

struct Guests: Codable {
    let guests : [Guest]
}
/////





//////
struct CreateEncounterRequestData: Codable{
    let status: String
    let message: String
    let result: encounterResult
}

struct encounterResult: Codable {
    let command: String
    let rowCount: Int
    let oid: String
    let rows: [EncounterRequestRows]
    let fields: [EncounterRequestFields]
    let _parsers: [parser1]
    //let _types: [types1]
}


struct parser1: Codable {
    var Parsers : [String]? = []

      enum CodingKeys: String, CodingKey {

        case Parsers = "_parsers"
      
      }

      init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        Parsers = try values.decodeIfPresent([String].self , forKey: .Parsers )
     
      }

      init() {

      }
}

struct EncounterRequestRows: Codable {
    let requestid: String
    let placeinqueue: String
    let sessionid: String
    let mobileid: String
    let meetinginfo: String
}

struct EncounterRequestFields: Codable {
    let name: String
    let tableID: Int64
    let columnID: Int64
    let dataTypeID: Int64
    let dataTypeSize: Int64
    let dataTypeModifier: Int64
    let format: String
}


struct Createroomdata: Codable {
    let room: Room
    let participants: [MParticipant]
    
}


struct MParticipant: Codable {
    
    let id: ID
    let role: String
    let data: ParticipantData
    
}

struct ParticipantData: Codable {
    let token: String
    let expiresOn: String
    let user: ID
}




struct Room: Codable {
    let createdOn: String
    let id: String
    let validFrom: String
    let validUntil: String
    let pstnDialOutEnabled: Bool
}

struct CreateICARequest: Codable {

  var status  : Int?    = nil
  var message : String? = nil
  var result  : Result? = Result()

  enum CodingKeys: String, CodingKey {

    case status  = "status"
    case message = "message"
    case result  = "result"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    status  = try values.decodeIfPresent(Int.self    , forKey: .status  )
    message = try values.decodeIfPresent(String.self , forKey: .message )
    result  = try values.decodeIfPresent(Result.self , forKey: .result  )
 
  }

  init() {

  }

}

struct Result: Codable {

  var requestid    : String? = nil
  var placeinqueue : String? = nil
  var sessionid    : String? = nil
  var mobileid     : String? = nil
  var meetinginfo  : String? = nil

  enum CodingKeys: String, CodingKey {

    case requestid    = "requestid"
    case placeinqueue = "placeinqueue"
    case sessionid    = "sessionid"
    case mobileid     = "mobileid"
    case meetinginfo  = "meetinginfo"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    requestid    = try values.decodeIfPresent(String.self , forKey: .requestid    )
    placeinqueue = try values.decodeIfPresent(String.self , forKey: .placeinqueue )
    sessionid    = try values.decodeIfPresent(String.self , forKey: .sessionid    )
    mobileid     = try values.decodeIfPresent(String.self , forKey: .mobileid     )
    meetinginfo  = try values.decodeIfPresent(String.self , forKey: .meetinginfo  )
 
  }

  init() {

  }

}
struct Rows: Codable {

  var requestid    : String? = nil
  var placeinqueue : String? = nil
  var sessionid    : String? = nil
  var mobileid     : String? = nil
  var meetinginfo  : String? = nil

  enum CodingKeys: String, CodingKey {

    case requestid    = "requestid"
    case placeinqueue = "placeinqueue"
    case sessionid    = "sessionid"
    case mobileid     = "mobileid"
    case meetinginfo  = "meetinginfo"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    requestid    = try values.decodeIfPresent(String.self , forKey: .requestid    )
    placeinqueue = try values.decodeIfPresent(String.self , forKey: .placeinqueue )
    sessionid    = try values.decodeIfPresent(String.self , forKey: .sessionid    )
    mobileid     = try values.decodeIfPresent(String.self , forKey: .mobileid     )
    meetinginfo  = try values.decodeIfPresent(String.self , forKey: .meetinginfo  )
 
  }

  init() {

  }

}

struct Fields: Codable {

  var name             : String? = nil
  var tableID          : Int?    = nil
  var columnID         : Int?    = nil
  var dataTypeID       : Int?    = nil
  var dataTypeSize     : Int?    = nil
  var dataTypeModifier : Int?    = nil
  var format           : String? = nil

  enum CodingKeys: String, CodingKey {

    case name             = "name"
    case tableID          = "tableID"
    case columnID         = "columnID"
    case dataTypeID       = "dataTypeID"
    case dataTypeSize     = "dataTypeSize"
    case dataTypeModifier = "dataTypeModifier"
    case format           = "format"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    name             = try values.decodeIfPresent(String.self , forKey: .name             )
    tableID          = try values.decodeIfPresent(Int.self    , forKey: .tableID          )
    columnID         = try values.decodeIfPresent(Int.self    , forKey: .columnID         )
    dataTypeID       = try values.decodeIfPresent(Int.self    , forKey: .dataTypeID       )
    dataTypeSize     = try values.decodeIfPresent(Int.self    , forKey: .dataTypeSize     )
    dataTypeModifier = try values.decodeIfPresent(Int.self    , forKey: .dataTypeModifier )
    format           = try values.decodeIfPresent(String.self , forKey: .format           )
 
  }

  init() {

  }

}

struct ArrayParser: Codable {

    var empty1: String? = nil
    enum CodingKeys: String, CodingKey {

   case empty1 = "empty1"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
      empty1 = try values.decode(String.self, forKey: .empty1)
 
  }

  init() {

  }

}

struct Builtins: Codable {

  var BOOL           : Int? = nil
  var BYTEA          : Int? = nil
  var CHAR           : Int? = nil
  var INT8           : Int? = nil
  var INT2           : Int? = nil
  var INT4           : Int? = nil
  var REGPROC        : Int? = nil
  var TEXT           : Int? = nil
  var OID            : Int? = nil
  var TID            : Int? = nil
  var XID            : Int? = nil
  var CID            : Int? = nil
  var JSON           : Int? = nil
  var XML            : Int? = nil
  var PGNODETREE     : Int? = nil
  var SMGR           : Int? = nil
  var PATH           : Int? = nil
  var POLYGON        : Int? = nil
  var CIDR           : Int? = nil
  var FLOAT4         : Int? = nil
  var FLOAT8         : Int? = nil
  var ABSTIME        : Int? = nil
  var RELTIME        : Int? = nil
  var TINTERVAL      : Int? = nil
  var CIRCLE         : Int? = nil
  var MACADDR8       : Int? = nil
  var MONEY          : Int? = nil
  var MACADDR        : Int? = nil
  var INET           : Int? = nil
  var ACLITEM        : Int? = nil
  var BPCHAR         : Int? = nil
  var VARCHAR        : Int? = nil
  var DATE           : Int? = nil
  var TIME           : Int? = nil
  var TIMESTAMP      : Int? = nil
  var TIMESTAMPTZ    : Int? = nil
  var INTERVAL       : Int? = nil
  var TIMETZ         : Int? = nil
  var BIT            : Int? = nil
  var VARBIT         : Int? = nil
  var NUMERIC        : Int? = nil
  var REFCURSOR      : Int? = nil
  var REGPROCEDURE   : Int? = nil
  var REGOPER        : Int? = nil
  var REGOPERATOR    : Int? = nil
  var REGCLASS       : Int? = nil
  var REGTYPE        : Int? = nil
  var UUID           : Int? = nil
  var TXIDSNAPSHOT   : Int? = nil
  var PGLSN          : Int? = nil
  var PGNDISTINCT    : Int? = nil
  var PGDEPENDENCIES : Int? = nil
  var TSVECTOR       : Int? = nil
  var TSQUERY        : Int? = nil
  var GTSVECTOR      : Int? = nil
  var REGCONFIG      : Int? = nil
  var REGDICTIONARY  : Int? = nil
  var JSONB          : Int? = nil
  var REGNAMESPACE   : Int? = nil
  var REGROLE        : Int? = nil

  enum CodingKeys: String, CodingKey {

    case BOOL           = "BOOL"
    case BYTEA          = "BYTEA"
    case CHAR           = "CHAR"
    case INT8           = "INT8"
    case INT2           = "INT2"
    case INT4           = "INT4"
    case REGPROC        = "REGPROC"
    case TEXT           = "TEXT"
    case OID            = "OID"
    case TID            = "TID"
    case XID            = "XID"
    case CID            = "CID"
    case JSON           = "JSON"
    case XML            = "XML"
    case PGNODETREE     = "PG_NODE_TREE"
    case SMGR           = "SMGR"
    case PATH           = "PATH"
    case POLYGON        = "POLYGON"
    case CIDR           = "CIDR"
    case FLOAT4         = "FLOAT4"
    case FLOAT8         = "FLOAT8"
    case ABSTIME        = "ABSTIME"
    case RELTIME        = "RELTIME"
    case TINTERVAL      = "TINTERVAL"
    case CIRCLE         = "CIRCLE"
    case MACADDR8       = "MACADDR8"
    case MONEY          = "MONEY"
    case MACADDR        = "MACADDR"
    case INET           = "INET"
    case ACLITEM        = "ACLITEM"
    case BPCHAR         = "BPCHAR"
    case VARCHAR        = "VARCHAR"
    case DATE           = "DATE"
    case TIME           = "TIME"
    case TIMESTAMP      = "TIMESTAMP"
    case TIMESTAMPTZ    = "TIMESTAMPTZ"
    case INTERVAL       = "INTERVAL"
    case TIMETZ         = "TIMETZ"
    case BIT            = "BIT"
    case VARBIT         = "VARBIT"
    case NUMERIC        = "NUMERIC"
    case REFCURSOR      = "REFCURSOR"
    case REGPROCEDURE   = "REGPROCEDURE"
    case REGOPER        = "REGOPER"
    case REGOPERATOR    = "REGOPERATOR"
    case REGCLASS       = "REGCLASS"
    case REGTYPE        = "REGTYPE"
    case UUID           = "UUID"
    case TXIDSNAPSHOT   = "TXID_SNAPSHOT"
    case PGLSN          = "PG_LSN"
    case PGNDISTINCT    = "PG_NDISTINCT"
    case PGDEPENDENCIES = "PG_DEPENDENCIES"
    case TSVECTOR       = "TSVECTOR"
    case TSQUERY        = "TSQUERY"
    case GTSVECTOR      = "GTSVECTOR"
    case REGCONFIG      = "REGCONFIG"
    case REGDICTIONARY  = "REGDICTIONARY"
    case JSONB          = "JSONB"
    case REGNAMESPACE   = "REGNAMESPACE"
    case REGROLE        = "REGROLE"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    BOOL           = try values.decodeIfPresent(Int.self , forKey: .BOOL           )
    BYTEA          = try values.decodeIfPresent(Int.self , forKey: .BYTEA          )
    CHAR           = try values.decodeIfPresent(Int.self , forKey: .CHAR           )
    INT8           = try values.decodeIfPresent(Int.self , forKey: .INT8           )
    INT2           = try values.decodeIfPresent(Int.self , forKey: .INT2           )
    INT4           = try values.decodeIfPresent(Int.self , forKey: .INT4           )
    REGPROC        = try values.decodeIfPresent(Int.self , forKey: .REGPROC        )
    TEXT           = try values.decodeIfPresent(Int.self , forKey: .TEXT           )
    OID            = try values.decodeIfPresent(Int.self , forKey: .OID            )
    TID            = try values.decodeIfPresent(Int.self , forKey: .TID            )
    XID            = try values.decodeIfPresent(Int.self , forKey: .XID            )
    CID            = try values.decodeIfPresent(Int.self , forKey: .CID            )
    JSON           = try values.decodeIfPresent(Int.self , forKey: .JSON           )
    XML            = try values.decodeIfPresent(Int.self , forKey: .XML            )
    PGNODETREE     = try values.decodeIfPresent(Int.self , forKey: .PGNODETREE     )
    SMGR           = try values.decodeIfPresent(Int.self , forKey: .SMGR           )
    PATH           = try values.decodeIfPresent(Int.self , forKey: .PATH           )
    POLYGON        = try values.decodeIfPresent(Int.self , forKey: .POLYGON        )
    CIDR           = try values.decodeIfPresent(Int.self , forKey: .CIDR           )
    FLOAT4         = try values.decodeIfPresent(Int.self , forKey: .FLOAT4         )
    FLOAT8         = try values.decodeIfPresent(Int.self , forKey: .FLOAT8         )
    ABSTIME        = try values.decodeIfPresent(Int.self , forKey: .ABSTIME        )
    RELTIME        = try values.decodeIfPresent(Int.self , forKey: .RELTIME        )
    TINTERVAL      = try values.decodeIfPresent(Int.self , forKey: .TINTERVAL      )
    CIRCLE         = try values.decodeIfPresent(Int.self , forKey: .CIRCLE         )
    MACADDR8       = try values.decodeIfPresent(Int.self , forKey: .MACADDR8       )
    MONEY          = try values.decodeIfPresent(Int.self , forKey: .MONEY          )
    MACADDR        = try values.decodeIfPresent(Int.self , forKey: .MACADDR        )
    INET           = try values.decodeIfPresent(Int.self , forKey: .INET           )
    ACLITEM        = try values.decodeIfPresent(Int.self , forKey: .ACLITEM        )
    BPCHAR         = try values.decodeIfPresent(Int.self , forKey: .BPCHAR         )
    VARCHAR        = try values.decodeIfPresent(Int.self , forKey: .VARCHAR        )
    DATE           = try values.decodeIfPresent(Int.self , forKey: .DATE           )
    TIME           = try values.decodeIfPresent(Int.self , forKey: .TIME           )
    TIMESTAMP      = try values.decodeIfPresent(Int.self , forKey: .TIMESTAMP      )
    TIMESTAMPTZ    = try values.decodeIfPresent(Int.self , forKey: .TIMESTAMPTZ    )
    INTERVAL       = try values.decodeIfPresent(Int.self , forKey: .INTERVAL       )
    TIMETZ         = try values.decodeIfPresent(Int.self , forKey: .TIMETZ         )
    BIT            = try values.decodeIfPresent(Int.self , forKey: .BIT            )
    VARBIT         = try values.decodeIfPresent(Int.self , forKey: .VARBIT         )
    NUMERIC        = try values.decodeIfPresent(Int.self , forKey: .NUMERIC        )
    REFCURSOR      = try values.decodeIfPresent(Int.self , forKey: .REFCURSOR      )
    REGPROCEDURE   = try values.decodeIfPresent(Int.self , forKey: .REGPROCEDURE   )
    REGOPER        = try values.decodeIfPresent(Int.self , forKey: .REGOPER        )
    REGOPERATOR    = try values.decodeIfPresent(Int.self , forKey: .REGOPERATOR    )
    REGCLASS       = try values.decodeIfPresent(Int.self , forKey: .REGCLASS       )
    REGTYPE        = try values.decodeIfPresent(Int.self , forKey: .REGTYPE        )
    UUID           = try values.decodeIfPresent(Int.self , forKey: .UUID           )
    TXIDSNAPSHOT   = try values.decodeIfPresent(Int.self , forKey: .TXIDSNAPSHOT   )
    PGLSN          = try values.decodeIfPresent(Int.self , forKey: .PGLSN          )
    PGNDISTINCT    = try values.decodeIfPresent(Int.self , forKey: .PGNDISTINCT    )
    PGDEPENDENCIES = try values.decodeIfPresent(Int.self , forKey: .PGDEPENDENCIES )
    TSVECTOR       = try values.decodeIfPresent(Int.self , forKey: .TSVECTOR       )
    TSQUERY        = try values.decodeIfPresent(Int.self , forKey: .TSQUERY        )
    GTSVECTOR      = try values.decodeIfPresent(Int.self , forKey: .GTSVECTOR      )
    REGCONFIG      = try values.decodeIfPresent(Int.self , forKey: .REGCONFIG      )
    REGDICTIONARY  = try values.decodeIfPresent(Int.self , forKey: .REGDICTIONARY  )
    JSONB          = try values.decodeIfPresent(Int.self , forKey: .JSONB          )
    REGNAMESPACE   = try values.decodeIfPresent(Int.self , forKey: .REGNAMESPACE   )
    REGROLE        = try values.decodeIfPresent(Int.self , forKey: .REGROLE        )
 
  }

  init() {

  }

}

struct Types2: Codable {

  var arrayParser : ArrayParser? = ArrayParser()
  var builtins    : Builtins?    = Builtins()

  enum CodingKeys: String, CodingKey {

    case arrayParser = "arrayParser"
    case builtins    = "builtins"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    arrayParser = try values.decodeIfPresent(ArrayParser.self , forKey: .arrayParser )
    builtins    = try values.decodeIfPresent(Builtins.self    , forKey: .builtins    )
 
  }

  init() {

  }

}

struct Text2: Codable {

    var empty1: String? = nil
  enum CodingKeys: String, CodingKey {

      case empty1 = "empty1"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
      empty1 = try values.decode(String.self, forKey: .empty1)
 
  }

  init() {

  }

}

struct Binary: Codable {

    var empty1: String? = nil
    enum CodingKeys: String, CodingKey {

   case empty1 = "empty1"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
      empty1 = try values.decode(String.self, forKey: .empty1)
 
  }

  init() {

  }

}

struct Types: Codable {

  var types  : Types2?  = Types2()
  var text   : Text2?   = Text2()
  var binary : Binary? = Binary()

  enum CodingKeys: String, CodingKey {

    case types  = "_types"
    case text   = "text"
    case binary = "binary"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    types  = try values.decodeIfPresent(Types2.self  , forKey: .types  )
    text   = try values.decodeIfPresent(Text2.self   , forKey: .text   )
    binary = try values.decodeIfPresent(Binary.self , forKey: .binary )
 
  }

  init() {

  }

}

struct PrebuiltEmptyResultObject: Codable {
    
    var requestid    : String? = nil
    var placeinqueue : String? = nil
    var sessionid    : String? = nil
    var mobileid     : String? = nil
    var meetinginfo  : String? = nil
    
    enum CodingKeys: String, CodingKey {
        
        case requestid    = "requestid"
        case placeinqueue = "placeinqueue"
        case sessionid    = "sessionid"
        case mobileid     = "mobileid"
        case meetinginfo  = "meetinginfo"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        requestid    = try values.decodeIfPresent(String.self , forKey: .requestid    )
        placeinqueue = try values.decodeIfPresent(String.self , forKey: .placeinqueue )
        sessionid    = try values.decodeIfPresent(String.self , forKey: .sessionid    )
        mobileid     = try values.decodeIfPresent(String.self , forKey: .mobileid     )
        meetinginfo  = try values.decodeIfPresent(String.self , forKey: .meetinginfo  )
        
    }
    
    init() {
        
    }
}

struct Result2: Codable {

  var command                   : String?                    = nil
  var rowCount                  : Int?                       = nil
  var oid                       : String?                    = nil
  var rows                      : [Rows]?                    = []
  var fields                    : [Fields]?                  = []
  var parsers                   : [String]?                  = []
  var types                     : Types?                     = Types()
  var RowCtor                   : String?                    = nil
  var rowAsArray                : Bool?                      = nil
  var prebuiltEmptyResultObject : PrebuiltEmptyResultObject? = PrebuiltEmptyResultObject()

  enum CodingKeys: String, CodingKey {

    case command                   = "command"
    case rowCount                  = "rowCount"
    case oid                       = "oid"
    case rows                      = "rows"
    case fields                    = "fields"
    case parsers                   = "_parsers"
    case types                     = "_types"
    case RowCtor                   = "RowCtor"
    case rowAsArray                = "rowAsArray"
    case prebuiltEmptyResultObject = "_prebuiltEmptyResultObject"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    command                   = try values.decodeIfPresent(String.self                    , forKey: .command                   )
    rowCount                  = try values.decodeIfPresent(Int.self                       , forKey: .rowCount                  )
    oid                       = try values.decodeIfPresent(String.self                    , forKey: .oid                       )
    rows                      = try values.decodeIfPresent([Rows].self                    , forKey: .rows                      )
    fields                    = try values.decodeIfPresent([Fields].self                  , forKey: .fields                    )
    parsers                   = try values.decodeIfPresent([String].self                  , forKey: .parsers                   )
    types                     = try values.decodeIfPresent(Types.self                     , forKey: .types                     )
    RowCtor                   = try values.decodeIfPresent(String.self                    , forKey: .RowCtor                   )
    rowAsArray                = try values.decodeIfPresent(Bool.self                      , forKey: .rowAsArray                )
    prebuiltEmptyResultObject = try values.decodeIfPresent(PrebuiltEmptyResultObject.self , forKey: .prebuiltEmptyResultObject )
 
  }

  init() {

  }

}
struct Result3: Codable {

  var status  : Int?    = nil
  var message : String? = nil
  var result  : Result2? = Result2()

  enum CodingKeys: String, CodingKey {

    case status  = "status"
    case message = "message"
    case result  = "result"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    status  = try values.decodeIfPresent(Int.self    , forKey: .status  )
    message = try values.decodeIfPresent(String.self , forKey: .message )
    result  = try values.decodeIfPresent(Result2.self , forKey: .result  )
 
  }

  init() {

  }

}
