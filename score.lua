function _score_convert_(score,digits)
	-- instead of just drawing 3453 as a score, display 003453 to make it look arcardy
	local strscore = tostring(score)
	maxscore = ""
	for z=1,digits do
		maxscore = maxscore.."9"
	end
	maxscore = tonumber(maxscore)
	digits = digits - strscore:len()
	local zerostring = ""
	for z=1,digits do
		-- digits isn't anything
		zerostring = zerostring.."0" -- multiple zeroes!
	end
	local finalstring = zerostring..strscore
	if (score > maxscore) then
		return tostring(maxscore)
	end
	return finalstring
end

return _score_convert_