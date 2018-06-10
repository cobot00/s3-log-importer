class InsertTransaction
  attr_reader :insert_count

  def initialize(model)
    @model = model
    @insert_count = 0
    @insert_buffer = []
  end

  def push(record)
    @insert_buffer << record

    return if @insert_buffer.size < 1000

    @model.import(@insert_buffer, validate: false)
    @insert_count += @insert_buffer.size
    @insert_buffer = []
  end

  def flush
    if @insert_buffer.size.positive?
      @model.import(@insert_buffer, validate: false)
      @insert_count += @insert_buffer.size
    end
  end
end
