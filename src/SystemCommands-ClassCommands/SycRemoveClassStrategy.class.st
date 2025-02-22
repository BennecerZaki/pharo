"
I am the abstract strategy used to remove classes from the system.

My concrete subclasses handle the possible actions when a user attempts to remove a class:
	- remove the class
	- remove the class, keeping the subclasses
	- Don't remove the class, but browse references/subclasses/users
	- Cancel the action
"
Class {
	#name : #SycRemoveClassStrategy,
	#superclass : #Object,
	#category : #'SystemCommands-ClassCommands'
}

{ #category : #testing }
SycRemoveClassStrategy class >> canExecuteWithReferences: hasReferences subclasses: hasSubclasses users: hasUsers [
	self subclassResponsibility 
]

{ #category : #'instance creation' }
SycRemoveClassStrategy class >> createForBrowser: aBrowser references: hasReferences subclasses: hasSubclasses users: hasUsers [

	| strategies |
	strategies := SortedCollection sortBlock: #orderForBrowser ascending.
	
	self allSubclassesDo: [ :each |
		(each isAbstract not and: [
			each canExecuteWithReferences: hasReferences subclasses: hasSubclasses users: hasUsers])
				ifTrue: [ strategies add: (each newForBrowser: aBrowser) ]].
	
	^strategies
]

{ #category : #testing }
SycRemoveClassStrategy class >> isAbstract [
	^self == SycRemoveClassStrategy 
]

{ #category : #'instance creation' }
SycRemoveClassStrategy class >> newForBrowser: aBrowser [

	^self new
]

{ #category : #execution }
SycRemoveClassStrategy >> execute: aSycRemoveClassCommand [
	self subclassResponsibility 
]

{ #category : #testing }
SycRemoveClassStrategy >> isComplexRefactoring [
	^false
]

{ #category : #execution }
SycRemoveClassStrategy >> orderForBrowser [
	"by default any new strategy will be at the end"
	^1000
]

{ #category : #execution }
SycRemoveClassStrategy >> userRequestString [
	self subclassResponsibility 
]
