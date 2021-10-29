module Gcp
  module WorkspaceService
    SCOPE = "https://www.googleapis.com/auth/drive https://www.googleapis.com/auth/spreadsheets".freeze

    def drive_service
      @_drive_service ||= init_drive_service
    end

    def sheets_service
      @_sheets_service ||= init_sheets_service
    end

    def init_drive_service
      drive_service = Google::Apis::DriveV3::DriveService.new
      drive_service = init_service(drive_service)
      drive_service
    end

    def init_sheets_service
      sheets_service = Google::Apis::SheetsV4::SheetsService.new
      sheets_service = init_service(sheets_service)
      sheets_service
    end

    def init_service(service)
      service.authorization = authorize
      service.authorization.fetch_access_token!
      service
    end

    def authorize
      @authorization ||= Google::Auth::ServiceAccountCredentials.make_creds(
        json_key_io: StringIO.new(Rails.application.credentials.gcp[:auth].to_json),
        scope: SCOPE
      )
    end
  end
end
