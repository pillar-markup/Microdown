"
I collect the paths of the local files that the figures of a document show, so that a site copies these files and nothing else of the book folder.

## Life cycle: who creates me and who uses me

1. `PRHtmlBookDocument>>writeDocument:` creates me once the passes of `pagesOf:` have run: `MicWebFigureSubstituter` replaced the PDF figures by their PNG and `MicPathRelativizer` made the local figures relative to the book folder.
2. It sends me `collect:` with the book and answers my `paths`, then copies each file from the book folder to the site.

## Responsibility:

- I answer the path of each figure with a relative reference (a file of the book), once, in the order of the document.
- I leave out web figures and absolute references (files outside the book folder, which `MicPathRelativizer` left absolute).
- I do not copy anything and do not check that the files exist: the site does.
- I am a pass of my own, like `MicPathRelativizer`: one job, one visit.

## Collaborators: 

- `MicFigureBlock`: I read its `reference`.
- `MicRelativeResourceReference`: gives the `path` of a relative reference.

## Public API and Key Messages

- `collect: aDocument` visits aDocument and answers the paths.
- `paths` the paths collected.

## Examples

```
MicFigureFileCollector exampleOfADocument paths
```

## Internal Representation

- `paths`: an `OrderedCollection` of strings, each once, relative to the book folder.

### Implementation Points

- Only figures: links to local files (`[code](files/x.st)`) are not collected, as `MicPathRelativizer` does not relativize them.
"
Class {
	#name : 'MicFigureFileCollector',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'paths'
	],
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'examples' }
MicFigureFileCollector class >> exampleOfADocument [
	"A collector that visited a document with a local figure shown twice and a web figure: its paths are figures/x.png, once."

	<sampleInstance>
	| collector |
	collector := self new.
	collector collect: (Microdown parse: '![One.](figures/x.png)

![Again.](figures/x.png)

![On the web.](https://pharo.org/web.png)').
	^ collector
]
