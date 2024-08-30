#pseudo_code_practice_find_three_in_string.rb

=begin

# write a method that determines the index of the 3rd occurrence of 
#  a given character in a string. 
#For instance, if the given character is 'x' and the string is 'axbxcdxex', 
#  the method should return 6 (the index of the 3rd 'x'). 
#If the given character does not occur at least 3 times, return nil.

pseudo-code:
array = string.chars		#change string to array of characters:
we will call our given comparison character `char`
string.chars.length will be used as our iteration limiter

continue the following until you reach the end of the array or if counter reaches 3
set counter to 0
	set value at each index to it's index if value == `char`
		also if it is a match...set counter+= 1
	else
		set value at said index to 0
	end

After all of this...we are left with an array of 0's 
	and elements containing their respective index values that match our criteria
Note: we stopped our systematic array evaluation after 3 exact matches of element[index] == `char`

Lastly: we just have to use the previous code to find the largest number in an array and output the result
		to get our answer

=end


def triple_occurrence_index(string, char)
  string = string.chars
  if string.count(char) < 3
    return nil
  else
    until string.count(char) == 3
    string.pop
    end
    puts string.rindex(char)
  end
end

triple_occurrence_index("axbxcdxex", "x")