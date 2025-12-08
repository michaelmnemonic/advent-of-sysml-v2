package L04_SantaCargoBay_Challenge {
    part def Sleigh {
        part cargoBay {
            item payload : Bag;
        }
    }

    part def Bag;

    part def BottomlessGiftBag specializes Bag {
        /* Define the bottomless gift bag that can hold any number of gifts (gifts are items). 
         * We are using a specializes relationship as a bottomless bag is a special kind of bag
         */
        item gifts [*]; // Note the "*" to indicate an unlimited amount of gifts
    }

    // Extend the model below as follows:

    /* Model Santa’s sleigh as a special kind of sleigh. */
    part def SantasSleight specializes Sleigh {
        // We want a special kind of cargoBay so we redefine it
        part redefines cargoBay {
            // - In this sleigh, the cargo bay’s payload should be called a gift bag.
            item giftbag
                redefines payload
                :
                    BottomlessGiftBag { // make use of the bottomless giftbag
                // - The gift bag should contain at least a toy train, a teddy bear, and a candy can - use subset to existing gift definition
                item toyTrain subsets gifts;
                item teddyBear subsets gifts;
                item candyCane subsets gifts;
            }
        }
    }
}
