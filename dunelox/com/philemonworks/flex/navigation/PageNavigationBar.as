/*
   Copyright 2007 Ernest.Micklei @ PhilemonWorks.com

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
package com.philemonworks.flex.navigation
{
	import mx.containers.HBox;
	import mx.controls.Button;
	import mx.controls.LinkButton;
	import mx.binding.utils.BindingUtils;
	import flash.text.TextLineMetrics;
	import mx.controls.Text;
	import flash.events.MouseEvent;
	/**
	 * PageNavigationBar is a dynamic control containing LinkButtons for pages from a range.
	 * Depending on the current page and the total number of pages, the bars shows:
	 * <ul>
	 * 	<li>a previous buttons (if valid)</li>
	 *  <li>dots between page 1 and the start of the page window</li>
	 *  <li>linkbuttons for each page of the page window (size=10)</li>
	 *  <li>dots between the last page of the window and the total pages</li>
	 *  <li>a next buttons (if valid)</li>
	 * </ul>
	 * 
	 * @author ernest.micklei@philemonworks.com
	 **/
	public class PageNavigationBar extends HBox
	{
		private static var BUTTON_WIDTH:int = 19;
		[Bindable]
		public var requestedPage:int = 0; // means no selection
		[Bindable]
		public var currentPageStyleName:String;
		
		public function updatePageControlsByRows(firstRowOnPage:Number,rowsPerPage:Number,totalRows:Number):void {
			var currentPage:int = firstRowOnPage / rowsPerPage + 1;
			var totalPages:int = Math.ceil(totalRows / Math.max(rowsPerPage,1)); // at least one page
			this.setPageControls(currentPage,totalPages);
		}
			
	    /**
		 * 
		 * @param currentPage
		 * @param totalPages
		 * 
		 */
		public function setPageControls(currentPage:int,totalPages:int):void {			
			this.removeAllChildren();
			// previous
			var prev:Button = new Button();
			prev.width = BUTTON_WIDTH;
			prev.label = "<";
			prev.toolTip = "Goto previous page";
			prev.addEventListener(MouseEvent.CLICK,previousPageButtonClicked);
			this.addChild(prev);
			// gray out if not applicable
			prev.enabled = currentPage > 1;
			// 1		
			this.addLink(1,1==currentPage);
			if (totalPages <= 1) {
				this.addNext(false)
				return
			}
			var left:int = 2;
			var right:int = 0;
			if (currentPage > 6 && totalPages > 10) {
				this.addDots();	
				left = Math.min(currentPage - 4,totalPages-9);										
				right = Math.min(left + 9,totalPages-1);
			} else {
				// without dots one page less
				right = Math.min(left + 8,totalPages-1);	
			}			
			this.addLinks(left,currentPage,right);
			// dots
			if (right < (totalPages-1)) this.addDots();			
			// totalPages	
			this.addLink(totalPages,totalPages==currentPage);
			// next
			this.addNext(currentPage < totalPages)
			
		}
		private function addNext(isEnabled:Boolean):void {
			var next:Button = new Button();
			next.width = BUTTON_WIDTH;
			next.label = ">";
			next.toolTip = "Goto next page";
			next.addEventListener(MouseEvent.CLICK,nextPageButtonClicked);
			this.addChild(next);
			// gray out if not applicable
			next.enabled = isEnabled
		}
		private function addDots():void {
			var dots:Text = new Text();
			dots.text = "...";
			this.addChild(dots);
		}
		private function addLinks(fromPage:int,currentPage:int,toPage:int):void {
			for (var i:int=fromPage; i<=toPage ; i++){
				this.addLink(i,i==currentPage);
			}
		}
		private function addLink(i:int,isCurrent:Boolean):void {
			var link:LinkButton = new LinkButton();	
			
			var label:String = i.toString();
			link.width = 5+(12*label.length);	// TODO dubious width computation	
			link.label = i.toString();
			link.addEventListener(MouseEvent.CLICK,pageButtonClicked);
			if (isCurrent){
				requestedPage = i;
				link.toolTip = "You see page "+i;
				if (currentPageStyleName != null) 
					link.styleName = currentPageStyleName;				
				else
					link.setStyle('color','#0000FF')
			} else {
				link.toolTip = "Goto page "+i;	
			}
			this.addChild(link);
		}		
		private function previousPageButtonClicked(event:MouseEvent):void {
	    	requestedPage--;
	    }
		private function nextPageButtonClicked(event:MouseEvent):void {
	    	requestedPage++;
	    }
	    private function pageButtonClicked(event:MouseEvent):void {
	    	var target:LinkButton = (LinkButton)(event.currentTarget);
	    	requestedPage = Number(target.label);
	    }		
	}
}