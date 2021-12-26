"
I test that rendering no class comments make microdown parser or renderer fail
"
Class {
	#name : #MicParsesAndRendersAllCommentsTest,
	#superclass : #TestCase,
	#category : #'Microdown-RichTextComposer-Tests-Composer'
}

{ #category : #tests }
MicParsesAndRendersAllCommentsTest >> testCommentFromChunkReadStream [
	"Test that we do not break on empty annotated blocks"
	Microdown asRichText: ChunkReadStream comment.
	Microdown asRichText: '!!'
]

{ #category : #tests }
MicParsesAndRendersAllCommentsTest >> testCommentFromConfigurationCommandLineHandler [
	Microdown asRichText: ConfigurationCommandLineHandler comment.
	"Command line handler for dealing with Metacello configurations from the command line

Usage: config [--help] <repository url> [<configuration>] [--install[=<version>]] [--group=<group>] [--username=<username>] [--password=<password>][--no-quit][--no-save]
	--help              show this help message
	--no-quit        keep the image running after configuration install
	--no-save       Don't save the image after configuration install
	<repository url>    A Monticello repository name 
	<configuration>     A valid Metacello Configuration name
	<version>           A valid version for the given configuration
	<group>             A valid Metacello group name
	<username>          An optional username to access the configuration's repository
	<password>          An optional password to access the configuration's repository
	
Examples:
	# display this help message
	pharo Pharo.image config
	
	# list all configurations of a repository
	pharo Pharo.image config $MC_REPOS_URL
	
	# list all the available versions of a confgurtation
	pharo Pharo.image config $MC_REPOS_URL ConfigurationOfFoo
	
	# install the stable version
	pharo Pharo.image config $MC_REPOS_URL ConfigurationOfFoo --install
	
	#install a specific version '1.5'
	pharo Pharo.image config $MC_REPOS_URL ConfigurationOfFoo --install=1.5
	
	#install a specific version '1.5' and only a specific group 'Tests'
	pharo Pharo.image config $MC_REPOS_URL ConfigurationOfFoo --install=1.5 --group=Tests
"
]

{ #category : #tests }
MicParsesAndRendersAllCommentsTest >> testCommentFromFluidBuilder [
	"Test that we do not break on empty code blocks"
	Microdown asRichText: '```
```'
]

{ #category : #tests }
MicParsesAndRendersAllCommentsTest >> testSmokeSignalAndChoke [
	| difficultClasses |
	"this test disables error handling and tries to render all class comments in the system"
	"Really, it is a test of the robustness of Microdown parsing and rendering"
	self skip. "I take too long for normal circumstances"
	difficultClasses := OrderedCollection new.
	Smalltalk globals allClasses do: [ :cl |
			[Microdown asRichText:  cl comment ]
			on: Exception 
			do: [ difficultClasses add: cl ]
		 ].
	self assert: difficultClasses isEmpty
]
