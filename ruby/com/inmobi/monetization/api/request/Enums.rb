########################################################################
 # Constants to help with supplement of additional request level user info
# @author Rishabh Chowdhary
########################################################################
class AdRequest 
	NONE = 0
	BANNER = 1
	INTERSTITIAL = 2
	NATIVE = 3
end

class Education
	HIGHSCHOOLORLESS = 0
	COLLEGEORGRADUATE = 1
	POSTGRADUATEORABOVE = 2
	UNKNOWN = 3
end

class Ethnicity
	HISPANIC = 0
	AFRICANAMERICAN = 1
	ASIAN = 2
	CAUCASIAN = 3
	OTHER = 4
	UNKNOWN = 5
end

class Gender
	UNKNOWN = 0
	MALE = 1
	FEMALE = 2
end

class HasChildren
	TRUE = 0
	FALSE = 1
	UNKNOWN = 2
end

class MaritalStatus
	SINGLE = 0
	RELATIONSHIP = 1
	ENGAGED = 2
	DIVORCED = 3
	UNKNOWN = 4
end

class SexualOrientation
	NONE = 0
	STRAIGHT = 1
	GAY = 2
	BISEXUAL = 3
	UNKNOWN = 4
end
