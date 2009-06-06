/*
   Copyright 2009 Ernest.Micklei @ PhilemonWorks.com

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/
package com.philemonworks.flex.net
{
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	/**
	 * This class can be used with the ActiveItemService as part of Cloudfork-ActiveItem-Glare-Dunelox
	 * 
	 * See http://cloudfork.googlecode.com
	 * See http://glare.googlecode.com
	 * See http://dunelox.googlecode.com
	 **/
	public class ActiveItemService extends RemoteService
	{
		// Subclass responsibilty
		protected function destination():String { 
			trace("Subclass should have overriden this method")
			return null 
		}
		
		// Return a subcollection (page) of objects from a sorted list of search results
		//
		// Invoke the listPage function remotely on a LessonService.
		// resultHandler will be called with an instance of Array
		public function listPage(from:int,to:int,sortKey:String,sortMethod:String,searchPattern:String,resultHandler:Function):void {
			trace(this+">>listPage("+String(from)+","+String(to)+","+String(sortKey)+","+String(sortMethod)+","+String(searchPattern)+")");
			var remoteObject:RemoteObject = this.newRemoteObject(destination());
			remoteObject.listPage.addEventListener(ResultEvent.RESULT, new ResultToFunctionAdaptor(resultHandler).onResult);
			remoteObject.listPage(from,to,sortKey,sortMethod,searchPattern);
		}

		// Stores the object into the underlying database. Inspect the service result for errors.
		//
		// Invoke the save function remotely on a LessonService.
		// resultHandler will be called with an instance of ServiceResult
		public function save(item:Object,resultHandler:Function):void {
			trace(this+">>save("+String(item)+")");
			var remoteObject:RemoteObject = this.newRemoteObject(destination());
			remoteObject.save.addEventListener(ResultEvent.RESULT, new ResultToFunctionAdaptor(resultHandler).onResult);
			remoteObject.save(item);
		}

		// Find the object stored at <id> from the underlying database. Returns nil if not found.
		//
		// Invoke the find function remotely on a LessonService.
		// resultHandler will be called with an instance of Lesson
		public function find(id:String,resultHandler:Function):void {
			trace(this+">>find("+String(id)+")");
			var remoteObject:RemoteObject = this.newRemoteObject(destination());
			remoteObject.find.addEventListener(ResultEvent.RESULT, new ResultToFunctionAdaptor(resultHandler).onResult);
			remoteObject.find(id);
		}

		// Removes the object stored at <id> from the underlying database
		//
		// Invoke the destroy function remotely on a LessonService.
		// resultHandler will be called with an instance of Boolean
		public function destroy(id:String,resultHandler:Function):void {
			trace(this+">>destroy("+String(id)+")");
			var remoteObject:RemoteObject = this.newRemoteObject(destination());
			remoteObject.destroy.addEventListener(ResultEvent.RESULT, new ResultToFunctionAdaptor(resultHandler).onResult);
			remoteObject.destroy(id);
		}		
	}
}