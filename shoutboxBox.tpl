<script type = "text/javascript">
smilies = null;
function toggle(obj) {
	var el = document.getElementById(obj);
		if (el = 'shoutboxSmileyContainer' && smilies != 1) {
			new Effect.Appear(obj);
			smilies = 1;
			saveSmilieStatus(1)
		} else if (el = 'shoutboxSmileyContainer' && smilies == 1) {
			new Effect.Fade(obj);
			smilies = 0;
			saveSmilieStatus(0)
		}
function saveSmilieStatus(value) {
	var ajaxRequest = new AjaxRequest();
	ajaxRequest.openPost('index.php?action=StatusSave'+SID_ARG_2ND, 'name=shoutboxSmilieStatus&status='+encodeURIComponent(value));
	}
}
</script>
<div class="border titleBarPanel shoutboxBox">
	<div class="containerHead">
	<div class="containerIcon">
		<a href="javascript: void(0)"
			onclick="openList('{@$box->getStatusVariable()}', { save: true })"><img
			src="{icon}minusS.png{/icon}" id="{@$box->getStatusVariable()}Image"
			alt="" />
		</a>
	</div>
	<div class="containerContent">
		<h3>{lang}wbb.portal.box.shoutbox.title{/lang}</h3>
	</div>
</div>
<div class="container-1" id="{@$box->getStatusVariable()}">
<div class="containerContent">
	<script type="text/javascript"
			src="{@RELATIVE_WCF_DIR}js/Shoutbox.class.js">
	</script> 
	<script type="text/javascript">
			//<![CDATA[
			var shoutboxEntries = new Hash();
			{foreach from=$box->entries item=entry}
				shoutboxEntries.set({@$entry->entryID}, {
					userID: {@$entry->userID},
					styledUsername: '{@$entry->getStyledUsername()|encodeJS}',
					username: '{@$entry->username}',
					time: '{@$entry->time|shorttime|encodeJS}',
					message: '{@$entry->getFormattedMessage()|encodeJS}',
					me: {@$entry->me},
					isDeletable: {@$entry->isDeletable()|intval},
					toUserID: {@$entry->toUserID},
					toUserName: '{@$entry->toUserName}',
					prefix: '{@$entry->getWhisperPrefix()|encodeJS}'
				});
			{/foreach}

				// init
				onloadEvents.push(function() {
					shoutbox = new Shoutbox('shoutbox', shoutboxEntries, {TIME_NOW}, {
						langDeleteEntry:	'{lang}wcf.shoutbox.entry.delete{/lang}',
						langDeleteEntrySure:	'{lang}wcf.shoutbox.entry.delete.sure{/lang}',
						imgDeleteEntrySrc:	'{icon}deleteS.png{/icon}',
						entryReloadInterval: 	{SHOUTBOX_RELOAD_INTERVAL},
						entrySortOrder: 	'{SHOUTBOX_ENTRY_SORT_ORDER}',
						unneededUpdateLimit:	{SHOUTBOX_UNNEEDED_UPDATE_LIMIT}
					});
				});
			//]]>
	</script>
<div class="border infoBox container-1">
	<div class="containerContent">
		<div id="shoutboxContent">
			{assign var=sortedShoutboxEntries value=$box->entries|array_reverse} 
			{foreach from=$sortedShoutboxEntries item=entry}
				<p id="shoutboxEntry{@$entry->entryID}">
					<span class="light">[{@$entry->time|shorttime}]</span>
					{if $entry->isDeletable()} 
						<a href="index.php?action=ShoutboxEntryDelete&amp;entryID={@$entry->entryID}&amp;t={@SECURITY_TOKEN}{@SID_ARG_2ND}"
							title="{lang}wcf.shoutbox.entry.delete{/lang}"><img
							src="{icon}deleteS.png{/icon}" alt="" /></a> 
					{/if} 
					<span style="font-weight: bold;">{@$entry->getWhisperPrefix()}</span> 
								
								<a href="#" style="text-decoration: none;">{@$entry->getStyledUsername()}</a>
						{if $entry->me = 0} :
							{@$entry->getFormattedMessage()}</p>
						{elseif $entry->me = 1} 
							{@$entry->getFormattedMessage()}</p>
						{/if} 
			{/foreach}
		</div>
	</div>
</div>
{if $portalMode != 'edit' && $this->user->getPermission('user.shoutbox.canAddEntry')}
	<form method="post" 
			action="index.php?action=ShoutboxEntryAdd"
			id="shoutboxEntryAddForm">
		<div id="shoutboxFormLayout-{if $this->user->userID == 0}2{else}1{/if}"
			style="width: 95%;"><a
			href="javascript: toggle('shoutboxSmileyContainer')"
			style="text-decoration: none;"> <img
			src="{@RELATIVE_WCF_DIR}icon/dropDownMenuS.png" alt="smilie"
			name="smilie" /> </a> {if $this->user->userID == 0} <input type="text"
			class="inputText" name="username" id="shoutboxUsername"
			value="{if $box->username|empty}{lang}wcf.user.username{/lang}{else}{$box->username}{/if}"
			onfocus="if (this.value == '{lang}wcf.user.username{/lang}') this.value='';"
			onblur="if (this.value == '') this.value = '{lang}wcf.user.username{/lang}'" />
{/if} 
			<input type="text" 
					class="inputText" name="message"
					id="shoutboxMessage" 
					value="" /> 
			<input type="image" 
					class="inputImage"
					id="shoutboxSubmit" 
					src="{icon}submitS.png{/icon}" /> 
			{@SID_INPUT_TAG}
		</div>
	</form>
{if SHOUTBOX_ENABLE_SMILEY_LIST}
<div class="" id="shoutboxSmileyContainer" style="display: none; max-height:300px;overflow:auto;">
{if $this->user->shoutboxSmilieStatus == 1}
<script type="text/javascript">
	//<![CDATA[
		toggle('shoutboxSmileyContainer')
	//]]>
</script>
{/if}
{if $this->user->getPermission('user.shoutbox.bbcode.b')}
<img src="wcf/icon/wysiwyg/fontStyleBoldM.png" onclick="shoutbox.insertBBCode('[b]','[\/b]');" alt=""/>
{/if}
{if $this->user->getPermission('user.shoutbox.bbcode.i')}
<img src="wcf/icon/wysiwyg/fontStyleItalicM.png" onclick="shoutbox.insertBBCode('[i]','[\/i]');" alt=""/>
{/if}
{if $this->user->getPermission('user.shoutbox.bbcode.u')}
<img src="wcf/icon/wysiwyg/fontStyleUnderlineM.png" onclick="shoutbox.insertBBCode('[u]','[\/u]');" alt=""/>
{/if}
{if $this->user->getPermission('user.shoutbox.bbcode.s')}
<img src="wcf/icon/wysiwyg/fontStyleStriketroughM.png" onclick="shoutbox.insertBBCode('[s]','[\/s]');" alt=""/>
{/if}
{if $this->user->getPermission('user.shoutbox.bbcode.img')}
<img src="wcf/icon/wysiwyg/insertImageM.png" onclick="shoutbox.insertBBCode ('[img]','[\/img]');"/>
{/if}
{if $this->user->getPermission('user.shoutbox.bbcode.center')}
<img src="wcf/icon/wysiwyg/textJustifyM.png" onclick="shoutbox.insertBBCode('[align=center]','[\/align]');" alt=""/>
{/if}
{if $this->user->getPermission('user.shoutbox.bbcode.align')}
<img src="wcf/icon/wysiwyg/textAlignRightM.png" onclick="shoutbox.insertBBCode('[align=right]','[\/align]');" alt=""/>
{/if}
{if $this->user->getPermission('user.shoutbox.bbcode.size')}
<select name="fontsize" style="height: 20px;" onchange="shoutbox.insertBBCode('[size=' + this.value + ']','[\/size]')">
<option value="" selected="selected">Schriftgröße:</option>
<option value="8" style="font-size: x-small;">sehr klein</option>
<option value="10" style="font-size: small;">klein</option>
<option value="14" style="font-size: medium;">mittel</option>
<option value="18" style="font-size: large;">groß</option>
<option value="24" style="font-size: x-large;">sehr groß</option>
<option value="30" style="font-size: x-large;">riesig</option>
</select>
{/if}
{if $this->user->getPermission('user.shoutbox.bbcode.font')}
<select name="font" style="height: 20px;" onchange="shoutbox.insertBBCode('[font=' + this.value + ']','[\/font]')">
<option value="" selected="selected">Schriftart:</option>
<option value="arial" style="font-family: Arial;">Arial</option>
<option value="comic sans ms" style="font-family: Comic Sans MS;">Comic Sans MS</option>
<option value="courier" style="font-family: Courier;">Courier</option>
<option value="courier new" style="font-family: Courier New;">Courier New</option>
<option value="tahoma" style="font-family: Tahoma;">Tahoma</option>
<option value="times new roman" style="font-family: Times New Roman;">Times New Roman</option>
<option value="verdana" style="font-family: Verdana;">Verdana</option>
</select>
{/if}
{if $this->user->getPermission('user.shoutbox.bbcode.color')}
<select name="fontcolor" style="height: 20px;" onchange="shoutbox.insertBBCode('[color=' + this.value + ']','[\/color]')">
<option value="" selected="selected">Schriftfarbe:</option>
<option value="skyblue" style="color: skyblue;">Himmelblau</option>
<option value="royalblue" style="color: royalblue;">Königsblau</option>
<option value="blue" style="color: blue;">Blau</option>
<option value="darkblue" style="color: darkblue;">Dunkelblau</option>
<option value="indigo" style="color: indigo;">Blau-Lila</option>
<option value="purple" style="color: purple;">Lila</option>
<option value="deeppink" style="color: deeppink;">Tiefrosa</option>
<option value="limegreen" style="color: limegreen;">Limonengrün</option>
<option value="teal" style="color: teal;">Seegrün</option>
<option value="Lime" style="color: #00FF00;">Lime</option>
<option value="Aqua" style="color: #00FFFF;">Aqua</option>
<option value="Cyan" style="color: #00FFFF;">Cyan</option>
<option value="seagreen" style="color: seagreen;">Meergrün</option>
<option value="green" style="color: green;">Grün</option>
<option value="orange" style="color: orange;">Orange</option>
<option value="coral" style="color: coral;">Korallenrot</option>
<option value="tomato" style="color: tomato;">Tomatenrot</option>
<option value="orangered" style="color: orangered;">Orange-Rot</option>
<option value="red" style="color: red;">Rot</option>
<option value="crimson" style="color: crimson;">Purpurrot</option>
<option value="firebrick" style="color: firebrick;">Ziegelrot</option>
<option value="darkred" style="color: darkred;">Dunkelrot</option>
<option value="sienna" style="color: sienna;">Dunkelbraun</option>
<option value="yellow" style="color: #ffff00;">Gelb</option>
<option value="Gold" style="color: #FFD700;">Gold</option>
<option value="chocolate" style="color: chocolate;">Schokobraun</option>
<option value="sandybrown" style="color: sandybrown;">Sandbraun</option>
<option value="burlywood" style="color: burlywood;">Kräftigholzbraun</option>
<option value="silver" style="color: silver;">Silber</option>
<option value="Black" style="color: #000000;">Black</option>
<option value="DarkSlateGray" style="color: #2F4F4F;">DarkSlateGray</option>
<option value="DimGray" style="color: #696969;">DimGray</option>
<option value="White" style="color: #FFFFFF;">Weiss</option>
<option value="Honeydew" style="color: #F0FFF0;">Honeydew</option>
<option value="Azure" style="color: #F0FFFF;">Azure</option>
</select>
{/if}
{if $this->user->getPermission('user.shoutbox.bbcode.quote')}
<img src="wcf/icon/wysiwyg/quoteM.png" onclick="shoutbox.insertBBCode('[quote]','[\/quote]');" alt=""/>
{/if}
{if $this->user->getPermission('user.shoutbox.bbcode.code')}
<img src="wcf/icon/wysiwyg/insertCodeM.png" onclick="shoutbox.insertBBCode('[code]','[\/code]');" alt=""/>
{/if}
{if $this->user->getPermission('user.shoutbox.bbcode.css')}
<img src="wcf/icon/wysiwyg/insertCssM.png" onclick="shoutbox.insertBBCode('[css]','[\/css]');" alt=""/>
{/if}
{if $this->user->getPermission('user.shoutbox.bbcode.html')}
<img src="wcf/icon/wysiwyg/insertHtmlM.png" onclick="shoutbox.insertBBCode('[html]','[\/html]');" alt=""/>
{/if}
{if $this->user->getPermission('user.shoutbox.bbcode.java')}
<img src="wcf/icon/wysiwyg/insertJavaM.png" onclick="shoutbox.insertBBCode('[java]','[\/java]');" alt=""/>
{/if}
{if $this->user->getPermission('user.shoutbox.bbcode.js')}
<img src="wcf/icon/wysiwyg/insertJavaScriptM.png" onclick="shoutbox.insertBBCode('[js]','[\/js]');" alt=""/>
{/if}
{if $this->user->getPermission('user.shoutbox.bbcode.php')}
<img src="wcf/icon/wysiwyg/insertPhpM.png" onclick="shoutbox.insertBBCode('[php]','[\/php]');" alt=""/>
{/if}
{if $this->user->getPermission('user.shoutbox.bbcode.mysql')}
<img src="wcf/icon/wysiwyg/insertMysqlM.png" onclick="shoutbox.insertBBCode('[mysql]','[\/mysql]');" alt=""/>
{/if}
{if $this->user->getPermission('user.shoutbox.c.java')}
<img src="wcf/icon/wysiwyg/insertCM.png" onclick="shoutbox.insertBBCode('[c]','[/c]');" alt=""/>
{/if}
<ul class="smileys">
	{foreach from=$box->smileys item=smiley}
		<li>
			<img onmouseover="this.style.cursor='pointer'"
					onclick="shoutbox.insertSmiley('{$smiley->smileyCode|encodeJS}');"
					src="{$smiley->getURL()}" alt=""
					title="{lang}{$smiley->smileyTitle}{/lang}" />
		</li>
	{/foreach}
</ul>
</div>
{/if} 
{/if}
</div>
</div>
</div>
