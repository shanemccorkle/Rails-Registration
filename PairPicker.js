// var array = ["Jonathan","Josh","Kaitlin","Ben","Kim","Krista","Michael","Nattapon","Olivia","Ramin","Russell","Shane","Vinh","Yosef"];
// numberPair = array.length/2;
// console.log(numberPair);
//
// if (array.length%2 == 0) {
//
//  for (i = 0; i < numberPair; i++ ) {
//    pair = (array.pop());
//    pairWith = Math.floor(Math.random() * (array.length));
//    console.log(pair + " pair with " + array[pairWith]);
//    array.splice(pairWith,1);
//  }
// } else {
//  console.log("Cannot pair this!");
// }
function picker(){
  var array = ["BLANK","Nat","Shane","Amir","Andrew","Christina","Daniel","David","Dominic","Isaac","Ben","Jonathan","Josh","Kaitlin","Kim","Krista","Michael","Olivia","Ramin","Russell","Vincent","Yosef"];
  var numberPair = array.length/2;
  var pair;
  var pairWith;
  var answer;
  var finalArray = [];

  if (array.length%2 == 0) {
  var answer;
   for (i = 0; i < numberPair; i++ ) {
     pair = (array.pop());
     pairWith = Math.floor(Math.random() * (array.length));
     answer = prompt(pair + " pairs with " + array[pairWith] +  ". Do you want to keep it? (Y/N)");
     if (answer.toUpperCase() != "Y") {
       array.push(pair);
       numberPair++;
     } else {
        console.log(pair + " pairs with " + array[pairWith]);
        finalArray.push(array[pairWith]);
        finalArray.push(pair);
        array.splice(pairWith,1);
     }
   }
  } else {
   console.log("Cannot pair this!");
  }
}
