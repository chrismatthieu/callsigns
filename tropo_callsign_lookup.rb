require 'rest_client'
require 'json'

answer
sleep 2
say "welcome to the tropo ham radio call sign lookup application"
say "spell the call sign phonetically. I will repeat it, but you can interrupt. say finish when done or restart to start over. "
callsign = ""
callsigntext = ""

loop do

  result = ask "#{callsigntext}", {
      :bargein => true,
      :choices => "alpha, bravo, charlie, delta, echo, foxtrot, golf, hotel, india, juliette, kilo, lima, mike, november, oscar, papa, quebec, romeo, sierra, tango, uniform, victor, whiskey, xray, yankee, zulu, one, two, three, four, five, six, seven, eight, nine, zero, finish, restart"}

  if result.value == "finish"
    break
  elsif result.value == "restart"
    callsign = ""
    callsigntext = ""
  else
    callsigntext = callsigntext + " " + result.value

    letter = case result.value
     when "alpha" then "a"
     when "bravo" then "b"
     when "charlie" then "c"
     when "delta" then "d"
     when "echo" then "e"
     when "foxtrot" then "f"
     when "golf" then "g"
     when "hotel" then "h"
     when "india" then "i"
     when "juliette" then "j"
     when "kilo" then "k"
     when "lima" then "l"
     when "mike" then "m"
     when "november" then "n"
     when "oscar" then "o"
     when "papa" then "p"
     when "quebec" then "q"
     when "romeo" then "r"
     when "sierra" then "s"
     when "tango" then "t"
     when "uniform" then "u"
     when "victor" then "v"
     when "whiskey" then "w"
     when "xray" then "x"
     when "yankee" then "y"
     when "zulu" then "z"
     when "one" then "1"
     when "two" then "2"
     when "three" then "3"
     when "four" then "4"
     when "five" then "5"
     when "six" then "6"
     when "seven" then "7"
     when "eight" then "8"
     when "nine" then "9"
     when "zero" then "0"
    end

    if letter
      callsign = callsign + letter
    end

  end

end

response = RestClient.get 'http://callook.info/' + callsign + '/json'
data = JSON.parse(response)

say callsigntext + "belongs to "
say data["name"]
say "in " + data["address"]["line2"]
say "and holds a " + data["current"]["operClass"] + " license"
