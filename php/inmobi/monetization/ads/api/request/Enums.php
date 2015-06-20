
<?php
/////////////////////////////////////////////////////////////////
// Copyright © 2015 InMobi Technologies Pte. Ltd. All rights reserved.

//                           MIT License

//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:

//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.

//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
////////////////////////////////////////////////////////////////////////////// 
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