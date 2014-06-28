require "the_interpolate/version"

module TheInterpolate; end

def the_interpolate str, params = {}
  params.each_pair do |key, val|
    ary = str.split("[:#{ key }:]")
    str = ary.join val.to_s if ary.size > 1
  end

  # Lazy (Ungreedy) regexp
  # word_char     => \w
  # non_word_char => \W
  # digit         => \d
  # non_digit     => \D
  # lazy          => *?
  str
    .gsub(/\.+/, '.')               # try to protect of escape from Dir
    .gsub(/~/, '')                  # try to protect of escape from Dir
    .gsub(/\[:[\w\W\d\D]*?:\]/, '') # cleanup unused interpolation keys
end

# test_str = "/uploads/free/crop/user/[:user_id:]/~/[:jail_break:]/[:empty:]main_image[:size:].jpg"

# params = {
#   empty: nil,
#   size: '_270x210',
#   user_id: :Ivan,
#   mommy: :mama,
#   dog: :gav_gav,
#   jail_break: '../...../../15'
# }

# puts the_interpolate test_str, params
