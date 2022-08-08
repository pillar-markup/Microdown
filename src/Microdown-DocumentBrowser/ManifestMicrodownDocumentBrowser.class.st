"
I implement a browser and editor for Microdown documents.
See comment in `MicDocumentBrowser`.

I implement two new kind of Microdown resource references: `MicPharoCommentResourceReference` and `MicGitHubRessourceReference`.

And I extend the MicFileResourceReference with icons for use in the documnt browser.

The classes in tag 'Model' are unused at the moment, but implement hierarchical structure over microdown documents and are just kept for reference for the time being (the issue is that some documents might be large, and it would be nice to browse a large document by sections in the tree view, but then what to do when trying to edit this large document).
"
Class {
	#name : #ManifestMicrodownDocumentBrowser,
	#superclass : #PackageManifest,
	#category : #'Microdown-DocumentBrowser-Manifest'
}

{ #category : #'code-critics' }
ManifestMicrodownDocumentBrowser class >> ruleBadMessageRule2V1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'Microdown-DocumentBrowser')) #'2022-07-13T10:42:18.082534+02:00') )
]
