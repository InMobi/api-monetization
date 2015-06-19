
<?php

/**
* Predefined enum constants.
**/

abstract class AdRequest {
	const NONE = 0;
	const BANNER = 1;
	const INTERSTITIAL = 2;
	const NATIVE = 3;
}

abstract class Education {
	const HIGHSCHOOLORLESS = 0;
	const COLLEGEORGRADUATE = 1;
	const POSTGRADUATEORABOVE = 2;
	const UNKNOWN = 3;
}

abstract class Ethnicity {
	const HISPANIC = 0;
	const AFRICANAMERICAN = 1;
	const ASIAN = 2;
	const CAUCASIAN = 3;
	const OTHER = 4;
	const UNKNOWN = 5;
}

abstract class Gender {
	const UNKNOWN = 0;
	const MALE = 1;
	const FEMALE = 2;

}

abstract class HasChildren {
	const TRUE = 0;
	const FALSE = 1;
	const UNKNOWN = 2;
}

abstract class MaritalStatus {
	const SINGLE =0;
	const RELATIONSHIP =1;
	const ENGAGED = 2;
	const DIVORCED = 3;
	const UNKNOWN = 4;

}

abstract class SexualOrientation {
	const STRAIGHT = 0;
	const GAY = 1;
	const BISEXUAL = 2;
	const UNKNOWN = 3;
}

?>