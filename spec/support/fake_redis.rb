class FakeRedis
  def initialize(db = {})
    @db = db
  end

  def set(key, val)
    db[key] = val
  end

  def get(key)
    db[key]
  end

  private

  attr_reader :db
end
