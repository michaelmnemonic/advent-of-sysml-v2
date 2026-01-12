package L08_SantaSleigh_Challenge {
        private import ScalarValues::*;

    package Structure {
        package Cargo {
            // Cargo Bay
            abstract part def CargoBay {
                item payload : Payload [1];
            }

            part def OrdinaryCargoBay specializes CargoBay {
                item redefines payload [1] : BottomlessGiftBag; 
            }

            part def MagicalCargoBay specializes CargoBay {
                item redefines payload [*] : OrdinaryBag; 
            }

            // Payload
            abstract part def Payload;
            part def BottomlessGiftBag specializes Payload;
            part def OrdinaryBag specializes Payload;

        }

        package Infrastructure {
            // Runner
            abstract part runners [2];

            // Reindeer
            abstract ref part reindeer : Reindeer[9];

            part def Reindeer {
                attribute energyLevel : Real;
                constant attribute noseColor;
                attribute weight: Real; // we assume the weight to change
                constant attribute name : String; // we do not assume the name to change
            }
        }

        package Sleigh {
            private import L05_SantaSleigh_Challenge::Structure::Infrastructure::*;

            part def SantaSleigh {
                part cockpit;
                // Task 1(a): define an abstract cargo bay
                

                // an ordinary cargo bay that may hold one payload that is a bottomless gift bag,
                

                // define different kind of payloads
                

                part cargoBay;
                part dashboard;



                // TASK 2:
                // Add composite or referential usages to model:
                
                // - exactly two runners, 
                part leftRunner [1] subsets runners; // enumerated as the left runner
                part rightRunner [1] subsets runners; //  and the right runner

                // - Mrs. Claus (Santa has to communicate with her during work)
                ref item MrsClaus; // note the "ref" indicating a reference

                // TASK 4:
                // Review the multiplicities int he whole model and specify it whenever the
                // default is not suitable.
                ref item santa;
                

                ref part dasher  subsets reindeer[1]; // we want to make sure to make it explicit that we a
                ref part dancer  subsets reindeer[1]; // referring to a single reindeer
                ref part prancer subsets reindeer[1];
                ref part vixen   subsets reindeer[1];
                ref part comet   subsets reindeer[1];
                ref part cupid   subsets reindeer[1];
                ref part donner  subsets reindeer[1];
                ref part blitzen subsets reindeer[1];
                ref part rudolph subsets reindeer[1];
                }
        }
    }    
}