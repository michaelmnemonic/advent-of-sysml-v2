package L05_SantaSleigh_Challenge {
    private import ScalarValues::*;

    part def SantaSleigh {
        part cockpit;
        // Task 1(a): define an abstract cargo bay
        abstract part def CargoBay {
            item payload : Payload [1];
        }

        // an ordinary cargo bay that may hold one payload that is a bottomless gift bag,
        part def OrdinayCargoBay specializes CargoBay {
            item redefines payload [1] : BottomlessGiftBag; 
        }

        // a magical cargo bay that can hold an arbitrary number of ordinary bags
        part def MagicalCargoBay specializes CargoBay {
            item redefines payload [*] : OrdinaryBag; 
        }

        // define different kind of payloads
        abstract part def Payload;
        part def BottomlessGiftBag specializes Payload;
        part def OrdinaryBag specializes Payload;

        part cargoBay;
        part dashboard;



        // TASK 2:
        // Add composite or referential usages to model:
        
        abstract part runners [2]; // - exctly two runners, 
        part leftRunner [1] subsets runners; // enumerated as the left runner
        part rightRunner [1] subsets runners; //  and the right runner

        // - Mrs. Claus (Santa has to communicate with her during work)
        ref item MrsClaus; // note the "ref" indicating a reference

        // TASK 4:
        // Review the multiplicities int he whole model and specify it whenever the
        // default is not suitable.
        ref item santa;
        abstract ref part reindeer : Reindeer[9];

        ref part dasher  subsets reindeer[1]; // we want to make sure to make it explit that we a
        ref part dancer  subsets reindeer[1]; // referring to a single reindeer
        ref part prancer subsets reindeer[1];
        ref part vixen   subsets reindeer[1];
        ref part comet   subsets reindeer[1];
        ref part cupid   subsets reindeer[1];
        ref part donner  subsets reindeer[1];
        ref part blitzen subsets reindeer[1];
        ref part rudolph subsets reindeer[1];
    }

    part def Reindeer {
        attribute energyLevel : Real;
        constant attribute noseColor;
        // TASK 3:
        // Add attributes to describe the weight and the name of the reindeer
        // (use constant if applicable).
        attribute weight: Real; // we assume the weight to change
        constant attribute name : String; // we do not assume the name to change
    }
}