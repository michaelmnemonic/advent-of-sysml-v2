package L03_SantaWorkshop {
        private import ScalarValues::*;

        part def SantaWorkshop {
                // Work areas of the workshop
                part assemblyLine {
                        doc
                        /* Where toys are assembled. */
                        part supervisor = headElf;
                }
                part qualityControl {
                        doc
                        /* Quality checking station. */
                }
                part packagingArea {
                        doc
                        /* Gift wrapping and packaging. */
                }

                // Elves working in the workshop
                part headElf;

                part albert : Elf {
                        attribute redefines skillType = SkillType::assembly;
                        attribute redefines skillLevel : Real := 50.0;
                }
                part betty : Elf {
                        attribute redefines skillType = SkillType::assembly;
                }
                part charlie : Elf {
                        attribute redefines skillType = SkillType::quality;
                }
                part diana : Elf {
                        attribute redefines skillType = SkillType::quality;
                }
                part edward : Elf {
                        attribute redefines skillType = SkillType::packaging;
                }
                part fiona : Elf {
                        attribute redefines skillType = SkillType::packaging;
                }
                part george : Elf {
                        attribute redefines skillType = SkillType::assembly;
                        attribute redefines skillLevel : Real := 150.0;
                }
                part helen : Elf {
                        attribute redefines skillType = SkillType::quality;
                        attribute redefines skillLevel : Real := 150.0;
                }
        }

        part def Elf {
                doc
                /* This is an Elf. Each elf has eactly one Skill and level that represents the mastery of said skill using a Real number */
                attribute skillType : SkillType;
                /* By default we assume a skill level of 100 */
                attribute skillLevel : Real default := 100;
        }

        enum def SkillType {
                enum assembly;
                enum quality;
                enum packaging;
        }
}
