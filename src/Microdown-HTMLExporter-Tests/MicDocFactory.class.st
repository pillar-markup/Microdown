Class {
	#name : #MicDocFactory,
	#superclass : #Object,
	#category : #'Microdown-HTMLExporter-Tests-Resources'
}

{ #category : #examples }
MicDocFactory class >> exampleMic [

	^ '#Lorem Ipsum
	
_Test page for Microdown functionality, exercising Microdown features to check that they render correctly in mobile/desktop._

!!AbstractLabel 

Abstract of article summarizing the page. This is a test page which exercises standard functionality and features of Microdown, from standard Microdown like blockquotes/headers/tables/images, to custom features like sidenotes, margin notes, left/right-floated and full-width images, columns, epigraphs, admonitions, small/wide tables, auto-smallcaps, collapse sections, link annotations, link icons.

#Heading 1

##Heading 2

###Heading 3

###Heading 4

####Heading 5

#####Heading 6

## Paragraphs

Body Text With Smallcaps Introduction: Margin note 1. A random Wikipedia link. Angel Adept Blind Bodice Clique Coast Dunce Docile Enact Eosin Furlong Focal Gnome Gondola Human Hoist Inlet Iodine Justin Jocose Knoll Koala Linden Loads Milliner Modal Number Nodule Onset Oddball Pneumo Poncho Quanta Qophs Rhone Roman Snout Sodium Tundra Tocsin Uncle Udder Vulcan Vocal Whale Woman Xmas Xenon Yunnan Young Zloty Zodiac. Angel angel adept for the nuance loads of the arena cocoa and quaalude. Blind blind bodice for the submit oboe of the club snob and abbot. Clique clique coast for the pouch loco of the franc assoc and accede. Dunce dunce docile for the loudness mastodon of the loud statehood and huddle. Enact enact eosin for the quench coed of the pique canoe and bleep. Furlong furlong focal for the genuflect profound of the motif aloof and offers. Gnome gnome gondola for the impugn logos of the unplug analog and smuggle. Human human hoist for the buddhist alcohol of the riyadh caliph and bathhouse. Inlet inlet iodine for the quince champion of the ennui scampi and shiite. Justin justin jocose for the djibouti sojourn of the oranj raj and hajjis. Knoll knoll koala for the banknote lookout of the dybbuk outlook and trekked. Linden linden loads for the ulna monolog of the consul menthol and shallot. Milliner milliner modal for the alumna solomon of the album custom and summon. Number number nodule for the unmade economic of the shotgun bison and tunnel.1 2 3 Onset onset oddball for the abandon podium of the antiquo tempo and moonlit. Pneumo pneumo poncho for the dauphin opossum of the holdup bishop and supplies. Quanta quanta qophs for the inquest sheqel of the cinq coq and suqqu. Rhone rhone roman for the burnt porous of the lemur clamor and carrot. Snout snout sodium for the ensnare bosom of the genus pathos and missing. Tundra tundra tocsin for the nutmeg isotope of the peasant ingot and ottoman. Uncle uncle udder for the dunes cloud of the hindu thou and continuum. Vulcan vulcan vocal for the alluvial ovoid of the yugoslav chekhov and revved. Whale whale woman for the meanwhile blowout of the forepaw meadow and glowworm. Xmas xmas xenon for the bauxite doxology of the tableaux equinox and exxon. Yunnan yunnan young for the dynamo coyote of the obloquy employ and sayyid. Zloty zloty zodiac for the gizmo ozone of the franz laissez and buzzing.4 The Dow dropped <10% before increasing >5%, and all the traders said “<what>”‽ Because markets never dropped before.

##Blockquotes

###Consecutive blockquotes:

> Margin note 2. Waltz, nymph, for quick jigs vex Bud. Sphinx of black quartz, judge my vow! Pack my box with five dozen liquor jugs. Glib jocks quiz nymph to vex dwarf. Jackdaws love my big sphinx of quartz. The five boxing wizards jump quickly. How vexingly quick daft zebras jump! Quick zephyrs blow, vexing daft Jim. Two driven jocks help fax my big quiz. The jay, pig, fox, zebra and my wolves quack! Sympathizing would fix Quaker objectives. A wizard’s job is to vex chumps quickly in fog. Watch Jeopardy!, Alex Trebek’s fun TV quiz game. By Jove, my quick study of lexicography won a prize! Waxy and quivering, jocks fumble the pizza.

> Another blockquote. Waltz, nymph, for quick jigs vex Bud. Sphinx of black quartz, judge my vow. Pack my box with five dozen liquor jugs. Glib jocks quiz nymph to vex dwarf. Jackdaws love my big sphinx of quartz. The five boxing wizards jump quickly. How vexingly quick daft zebras jump! Quick zephyrs blow, vexing daft Jim. Two driven jocks help fax my big quiz. The jay, pig, fox, zebra and my wolves quack! Sympathizing would fix Quaker objectives. A wizard’s job is to vex chumps quickly in fog. Watch Jeopardy!, Alex Trebek’s fun TV quiz game. By Jove, my quick study of lexicography won a prize! Waxy and quivering, jocks fumble the pizza.

###Nested blockquotes

> Blockquote
> > Nested blockquote

##Horizontal Rulers

****

##Tabular Data

|First Header | Second Header|
|-------------| -------------|
|Content Cell | Content Cell |
|Content Cell | Content Cell |

##Inline Formatting

_Italic element_. 

**Bold**. 

_**Bold italics**_.

**__Strong emphasized text__**

Here is an external link: [http://pharo.org](http://pharo.org).

Here is an internal link: [heading-1](#heading-1)

##Lists

- Bullet List item 1
- Bullet List item 2
- Bullet List item 3
  - Nested item 3.1
  - Nested item 3.2
- Bullet List item 4
  - Nested item 4.1
'
]

{ #category : #examples }
MicDocFactory class >> exampleMicAsHTMLBodyString [
	"Note this answer the HTML <String> matching the body part of a document, it does NOT build a HTML document"

	^ Microdown asHTMLString: self exampleMic
]

{ #category : #examples }
MicDocFactory class >> exampleMicAsHTMLDocument [
	"This example shows specifically how to set up an output directory and file name, as well as a CSS template to decorate the generated document."
	<example>

	MicHTMLDocument new
		addCSSNamed: 'Tufte';
		destinationPath: 'html_output';
		fromMicrodown: self exampleMic;
		writeToFileNamed: 'Chapter1.html'.
]

{ #category : #examples }
MicDocFactory class >> exampleMicAsHTMLDocumentInBrowser [

	| htmlDoc |
	
	htmlDoc :=  MicHTMLDocument new 
		fromMicrodown: self exampleMic;
		yourself.
	WebBrowser openOn: htmlDoc fullName.
]

{ #category : #examples }
MicDocFactory class >> exampleMicAsHTMLDocumentMWE [
	"This example is a Minimum Working Example to write a HTML document from Microdown content."
	<example>

	MicHTMLDocument new
		addCSSNamed: 'Tufte';
		fromMicrodown: self exampleMicAsHTMLBodyString;
		writeToFile.
]

{ #category : #examples }
MicDocFactory class >> exampleMicAsHTMLString [
	"This example shows specifically how to set up an output directory and file name, as well as a CSS template to decorate the generated document."
	<example>

	^ MicHTMLDocument new
		addCSSNamed: 'Tufte';
		destinationPath: 'html_output';
		fromMicrodown: self exampleMic;
		writeToFileNamed: 'Chapter1.html';
		yourself
]

{ #category : #examples }
MicDocFactory class >> exampleMicAsRichText [

	^ (Microdown asRichText: self exampleMic) inspect
]
