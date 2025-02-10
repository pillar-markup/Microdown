# Microdown tools: Checkers

Microdown proposes several tools to help document writers. In this chapter, we present the one related to
book validation and the available checkers. 

Three kinds exist
- Reference. The checker checks for anchors and references. 
- Code validation. The checker checks whether code snippets are correctly executed.
- Version validation. The checker checks whether the code snippet is the same as in Pharo.

Note that other tools are under development such as the help to hide method body automatically so that writers can write manuals where readers should provide answers.

### References

Microdown via the Pillar compilation chain offers the possibility to report:

- Duplicated anchors. 
- References to unexisting anchors
- Unreferenced figures
- Missing figure files
- Missing input files

Note that such verification takes into account section, figure, and equation anchors.

Here is an extract of a report produced by the checker. 

```
pillar referenceCheck index.md
```

```
File index.md has reference problems.

## Undefined input files:

	Undefined file input: booklet-PharoVirtualMachine/Part2-JIT/CallingConventions/CallingConventions.md (in file /Users/ducasse/Workspace/FirstCircle/MyBooks/Bk-Writing/PharoBooks2/Booklet-PharoVirtualMachine/index.md) refer to file that does not exist.


## Duplicated Anchors:

	Anchor sec:references is duplicated in file: Booklet-PharoVirtualMachine/Part0-Preamble/1-ObjectStructure/objectStructure.md
	Anchor sec:references is duplicated in file: PharoBooks2/Booklet-PharoVirtualMachine/Part0-Preamble/1-ObjectStructure/objectStructure.md


## Undefined Anchors:

	Anchor Ephemerons is undefined in file: /Users/ducasse/Workspace/FirstCircle/MyBooks/Bk-Writing/PharoBooks2/Booklet-PharoVirtualMachine/Part3-MemoryManagement/GarbageCollector/ephemerons.md
	...

## Unreferenced Figures

	Figure 'figures/interpreter_variables.pdf' with anchor 'interpreterVariables' (in file /Users/ducasse/Workspace/FirstCircle/MyBooks/Bk-Writing/PharoBooks2/Booklet-PharoVirtualMachine/Part1-InterpreterAndBytecode/4-Interpreter/theInterpreter.md) is not referenced.
	...
```

### Code snippet validation

Microdown supports the automatic validation of code snippets.
The following snippets illustrate the points. 

Here the writer wants to make sure that the expression 3 + 4 returns the correct result 7. He tags the code and use the `>>>` on a separate line. 

```
    ```example=true	3 + 4 	>>> 7	```
```

He can also declare that a given expression is expected to give a failure

```
	```example=true&expectedFailure=true	3 + 4 	>>> 12		
	```	```


	