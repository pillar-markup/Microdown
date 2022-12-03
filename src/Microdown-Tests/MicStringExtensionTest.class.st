"
I test the string extensions made by Microdown
"
Class {
	#name : #MicStringExtensionTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Parser'
}

{ #category : #tests }
MicStringExtensionTest >> testStripNTabs [
	| one five |
	one := String tab.
	five := one repeat: 5.
	self
		assert: ('' stripNtabs: 5) equals: '';
		assert: ('aaa' stripNtabs: 5) equals: 'aaa';
		assert: ('aaa' stripNtabs: 0) equals: 'aaa';
		assert: ('aaa' stripNtabs: 2) equals: 'aaa';
		assert: (one,'' stripNtabs: 2) equals: '';
		assert: (one,'a' stripNtabs: 1) equals: 'a';
		assert: (one,'a' stripNtabs: 0) equals: (one,'a');
		assert: (five,'a' stripNtabs: 4) equals: (one,'a');
		assert: (five,'a' stripNtabs: 5) equals: 'a';
		assert: (five,'a' stripNtabs: 8) equals: 'a'
]

{ #category : #tests }
MicStringExtensionTest >> testWithoutPreTabs [
	| one five |
	one := String tab.
	five := one repeat: 5.
	self 
		assert: '' withoutPreTabs equals: '';
		assert: 'a' withoutPreTabs equals: 'a';
		assert: (one,'a') withoutPreTabs equals: 'a';
		assert: (five,'aaa') withoutPreTabs equals: 'aaa';
		assert: (five,'aaa',one) withoutPreTabs equals: ('aaa',one)
]
