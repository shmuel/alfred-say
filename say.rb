$: << "builder-3.0.0/lib"
require 'builder'

xml = Builder::XmlMarkup.new
xml.items do
	voices = `say -v ?`.split("\n")
	voices.each do | voice |
		matchData = voice.match(/^([\w ]+)\s+\w+\s+# (.*)$/)
		voiceName = matchData[1].strip
		voiceSaying = matchData[2].strip
		xml.item :uid => voiceName, :arg => %|-v "#{voiceName}" "#{$pitchAndRate} #{$query}"| do
			xml.title voiceName
			xml.subtitle voiceSaying
			xml.icon "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/UserIcon.icns"
		end
	end
end

puts xml.target!