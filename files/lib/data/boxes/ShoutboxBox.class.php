<?php
// wbb imports
require_once(WBB_DIR.'lib/data/boxes/PortalBox.class.php');
require_once(WBB_DIR.'lib/data/boxes/StandardPortalBox.class.php');

// wcf imports
require_once(WCF_DIR.'lib/data/shoutbox/ShoutboxEntryFactory.class.php');

/**
 * Shows the shoutbox in a portal box.
 * 
 * @author	Sebastian Oettl
 * @copyright	2009-2011 WCF Solutions <http://www.wcfsolutions.com/index.html>
 * @license	GNU Lesser General Public License <http://opensource.org/licenses/lgpl-license.php>
 * @package	com.wbb3addons.portal.shoutbox
 */
class ShoutboxBox extends PortalBox implements StandardPortalBox {
	public $stylesheet = 'shoutboxbox';
	public $factory = null;
	public $entries = array();
	public $smileys = array();
	public $username = '';
	
	/**
	 * @see StandardPortalBox::readData()
	 */
	public function readData() {
		
		// get shoutbox entry factory
		$this->factory = new ShoutboxEntryFactory();
		$this->factory->entryList->sqlLimit = SHOUTBOX_MAX_ENTRIES;
		$this->factory->init();
		
		// get entries
		$this->entries = $this->factory->getEntries();
			
		// get smileys
		$this->smileys = $this->factory->getSmileys();
		
		// get username
		$this->username = WCF::getSession()->username;
	}

	/**	 
	 * @see StandardPortalBox::getTemplateName()
	 */
	public function getTemplateName() {
		return 'shoutboxBox';
	}
}
?>