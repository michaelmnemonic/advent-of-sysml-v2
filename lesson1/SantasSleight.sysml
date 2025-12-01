package SantasSleight {
    doc /* This package contains a model of Santas Sleight */

    part SantasSleight {
        attribute url = "./sleight.png";
        part cariage[1] {
            doc /* The main body of the sleight */
            part bench[1]{
                doc /* There is room for two people to sit, or one large human.*/
            }
            part giftCompartment[1]{
                doc /* Storage space for presents */
                part presents[0..4071]{
                    doc /* How does it store this many, but very specifc amount of presents? */
                    attribute recepient;
                }
            }
            part skids[2] {
                doc /* Runners to make it go over snow */
            }
        }
    }
}