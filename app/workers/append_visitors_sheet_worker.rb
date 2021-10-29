class AppendVisitorsSheetWorker
  include Sidekiq::Worker
  include Gcp::WorkspaceService

  RANGE_NAME = 'A:C'.freeze
  INSERT_DATA_OPTION = 'INSERT_ROWS'.freeze
  VALUE_INPUT_OPTION = 'RAW'.freeze

  def perform(name, email)
    values = [[name, email, DateTime.current]]
    value_range = Google::Apis::SheetsV4::ValueRange.new(range_name: RANGE_NAME, values: values)
    sheets_service.append_spreadsheet_value(Settings.gcp.metaverse_visitors_sheet,
                                            RANGE_NAME,
                                            value_range,
                                            insert_data_option: INSERT_DATA_OPTION,
                                            value_input_option: VALUE_INPUT_OPTION)
  end
end
