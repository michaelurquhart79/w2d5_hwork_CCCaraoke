require('minitest/autorun')
require('minitest/rg')
require_relative('../song')


class TestRoom < Minitest::Test

  def setup
    @song1 = Song.new("Hey Jude")
  end

  def test_song_has_name
    assert_equal("Hey Jude", @song1.name)

  end


end
