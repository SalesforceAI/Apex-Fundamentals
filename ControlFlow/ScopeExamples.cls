/*
 * - Block scope
 * - Loop scope
 * - Conditional scope
 * - Assignment timing & overwrite
 * - Unassigned variables (null)
 * - Same-name redeclaration (shadowing) NOT allowed in Apex
 */
public class ScopeExamples {

    public static void runAll() {
        example01_blockScope();
        example02_assignmentInsideBlock();
        example03_loopOverwrite();
        example04_conditionalAssignment();
        example05_unassignedVariable();
        example06_nestedOverwrite();
        example07_orderMatters();
        example08_sameNameRedeclare_notAllowed();
        example09_parameterShadowing_notAllowed();
    }

    //  Block scope visibility
    public static void example01_blockScope() {

        Integer x = 10;

        {
            Integer y = 20;
            System.debug('Inside block x = ' + x);
        }

        System.debug('Outside block x = ' + x);
    }
    /*
    Output:
    Inside block x = 10
    Outside block x = 10
    */

    //  Assignment inside block persists
    public static void example02_assignmentInsideBlock() {

        Integer x;

        {
            x = 15;
        }

        System.debug('x = ' + x);
    }
    /*
    Output:
    x = 15
    */

    //  Loop overwrite behavior (last assignment wins)
    public static void example03_loopOverwrite() {

        Integer x = 0;

        for (Integer i = 1; i <= 3; i++) {
            x = i;
        }

        System.debug('Final x = ' + x);
    }
    /*
    Output:
    Final x = 3
    */

    //  Conditional assignment
    public static void example04_conditionalAssignment() {

        Integer x = 5;

        if (true) {
            x = 20;
        }

        System.debug('x = ' + x);
    }
    /*
    Output:
    x = 20
    */

    //  Declared but never assigned -> null
    public static void example05_unassignedVariable() {

        Integer x;

        if (false) {
            x = 100;
        }

        System.debug('x = ' + x);
    }
    /*
    Output:
    x = null
    */

    //  Nested overwrite (assignment inside condition)
    public static void example06_nestedOverwrite() {

        Integer x = 1;

        for (Integer i = 1; i <= 3; i++) {

            Integer y = x;

            if (i == 2) {
                x = y + 5;
            }
        }

        System.debug('Final x = ' + x);
    }
    /*
    Output:
    Final x = 6
    */

    //  Order matters (advanced overwrite timing)
    public static void example07_orderMatters() {

        Integer x = 2;

        for (Integer i = 1; i <= 3; i++) {

            Integer y = x;

            x = x + i;

            if (i == 2) {
                Integer z = x;
                x = z + y;
            }
        }

        System.debug('Final x = ' + x);
    }
    /*
    Output:
    Final x = 11
    */

    //  Same-name redeclaration (shadowing) is NOT allowed in Apex
    public static void example08_sameNameRedeclare_notAllowed() {

        Integer x = 10;

        //  Apex does NOT allow redeclaring x inside a nested block in the same method.
        // Uncomment to see the compile error:
        /*
        if (true) {
            Integer x = 20; // Compile error: Variable already defined: x
            System.debug('Inner x = ' + x);
        }
        */

        System.debug('Outer x = ' + x);
    }
    /*
    Output (as written):
    Outer x = 10

    If you uncomment the inner "Integer x = 20;" line:
    Compile Error:
    Variable already defined: x
    */

    //  Method parameter shadowing is NOT allowed in Apex
    public static void example09_parameterShadowing_notAllowed() {
        testMethod(10);
    }

    private static void testMethod(Integer x) {

        // Apex does NOT allow redeclaring a parameter name as a local variable.
        // Uncomment to see the compile error:
        /*
        if (true) {
            Integer x = 20; // Compile error: Variable already defined: x
            System.debug('Inner x = ' + x);
        }
        */

        System.debug('Parameter x = ' + x);
    }
    /*
    Output (as written):
    Parameter x = 10

    If you uncomment the inner "Integer x = 20;" line:
    Compile Error:
    Variable already defined: x
    */
}
