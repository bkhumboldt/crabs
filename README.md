# crabs

Introduction: crabs is a kids computer game where a captain tries to catch a crab

Function: getCapt: number -> matrix <br>
Purpose: This function generates a matrix representation of the Captain character at the origin with zero heading. <br>
Its input number is the size of the Captain character to be returned. Each column of the captain matrix is a point of the captain. <br>
These points are homogenous column vectors who first element is x, second y, and third is 1. The coordinate system is x increasing to the right and y increasing down. <br>
Depencencies: None. <br>
Call: capt = getCapt(50); will generate a matrix called capt of size 50 <br>
Side effects: None
