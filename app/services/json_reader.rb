class JsonReader
  attr_reader :file_path
  def initialize(file_path)
    @file_path = file_path
  end
  
  def call
    file = File.read(file_path)
    JSON.parse(file)
  end
end
