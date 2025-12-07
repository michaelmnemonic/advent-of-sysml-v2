import pathlib
import syside

# Path to our SysML model file
LESSON_DIR = pathlib.Path(__file__).parent.parent
MODEL_FILE_PATH = LESSON_DIR / "advent-of-sysml-v2" / "lesson02" / "models" / "L02_SantaSleigh.sysml"


def find_element_by_name(model: syside.Model, name: str) -> syside.Element | None:
    """Search the model for a specific element by name."""

    # Iterates through all model elements that subset Element type
    # e.g. PartUsage, ItemUsage, OccurrenceUsage, etc.
    for element in model.elements(syside.Element, include_subtypes=True):
        if element.name == name:
            return element
    return None


def show_part_attributes(part: syside.Element, part_level: int = 0) -> None:
    """
    Prints a list of attributes for the input part.
    """
    # Print root element regardless of type
    # e.g. if it is a Package or PartDefinition
    if part_level == 0:
        print(part.name)
    elif type(part) is syside.PartUsage:
        # Indent based on nesting depth
        print("  " * part_level, "└", part.name)
        # output attribute as a bullet list
        for owned_element in part.owned_elements:
            if type(owned_element) is syside.AttributeUsage:
                print(" " * (part_level+3) , "• attribute: ", owned_element.name)

    # Print subparts by calling the same function again for each child
    for owned_element in part.owned_elements:
        show_part_attributes(owned_element, part_level + 1)



def main() -> None:
    # Load SysML model and get diagnostics (errors/warnings)
    (model, diagnostics) = syside.load_model([MODEL_FILE_PATH])

    # Make sure the model contains no errors before proceeding
    assert not diagnostics.contains_errors(warnings_as_errors=True)

    root_element = find_element_by_name(model, "SantaSleigh")

    print("\nPrinting part attributes:\n")
    show_part_attributes(root_element)


if __name__ == "__main__":
    main()
