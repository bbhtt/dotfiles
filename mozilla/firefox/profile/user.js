// FF

user_pref("accessibility.typeaheadfind.flashBar", 0);

// Don't show about:welcome page
user_pref("browser.aboutwelcome.enabled", false);
// Privacy and Security > Enhanced Tracking Protection level
user_pref("browser.contentblocking.category", "strict");
// General > Tabs > Ctrl+Tab cycles through tabs in recently used order
user_pref("browser.ctrlTab.sortByRecentlyUsed", true);
//  General > Colors > Use system colors
user_pref("browser.display.use_system_colors", true);
// GNOME search provider
user_pref("browser.gnome-search-provider.enabled", true);
// Home > Home content
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", true);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeBookmarks", true);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeDownloads", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeVisited", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
// General > Don't check default browser
user_pref("browser.shell.checkDefaultBrowser", false);
// Home >  New windows and tabs
user_pref("browser.startup.homepage", "about:home");
// Show PID on tabs Fission
user_pref("browser.tabs.tooltipsShowPidAndActiveness", true);
// Hide bookmarks bar
user_pref("browser.toolbars.bookmarks.visibility", "never");
// Search > Search suggestions > Show search suggestions ahead of browsing history
user_pref("browser.urlbar.showSearchSuggestionsFirst", false);
// Search > Search suggestions > Show search suggestions in address bar results
user_pref("browser.urlbar.suggest.engines", true);
user_pref("browser.urlbar.suggest.searches", true);
user_pref("browser.urlbar.suggest.topsites", true);
// General > Tabs > Confirm before quitting with Ctrl+Q
user_pref("browser.warnOnQuitShortcut", false);

// Privacy and Security > Cookie Banner Reduction > Reduce Cookie Banners
user_pref("cookiebanners.service.mode", true);

//  Privacy and Security > Nightly Data Collection and Use
user_pref("datareporting.healthreport.uploadEnabled", false);
// Privacy and Security > HTTPS-Only Mode > Enable HTTPS-Only Mode in all windows
user_pref("dom.security.https_only_mode", true);

user_pref("extensions.pictureinpicture.enable_picture_in_picture_overrides", true);
// Disable pocket
user_pref("extensions.pocket.enabled", false);
// Disable address autofill
user_pref("extensions.formautofill.addresses.enabled", false);
// Disable credit card autofill
user_pref("extensions.formautofill.creditCards.enabled", false);

// General > Fonts > Advanced
user_pref("font.name.monospace.x-western", "Delugia Mono");
user_pref("font.size.monospace.x-western", 13);

user_pref("intl.accept_languages", "en");
user_pref("intl.locale.requested", "");
//user_pref("intl.regional_prefs.use_os_locales", true);

// Privacy and Security > Permissions > Autoplay > Block audio and video
user_pref("media.autoplay.default", 5);
// Home > Digital Rights Management (DRM) Content > Play DRM content
user_pref("media.eme.enabled", true);
// Hardware acceleration with VAAPI
// Enabled by default on >=103 with Mesa >=21.0 and supported hardware
//user_pref("media.ffmpeg.vaapi.enabled", true);
// Disable zomming with Ctrl + mousewheel
user_pref("mousewheel.with_control.action", 1);

// Enable ECH
user_pref("network.dns.echconfig.enabled", true);
// Firefox DOH mode 3 = don't fallback to system resolver
//user_pref("network.trr.mode", 3);
// Home > Network settings > DOH provider
//user_pref("network.trr.custom_uri", "https://doh.in.ahadns.net/dns-query");
//user_pref("network.trr.uri", "https://doh.in.ahadns.net/dns-query");
//user_pref("network.trr.custom_uri", "https://blitz.ahadns.com/1:1.6.7");
//user_pref("network.trr.uri", "https://blitz.ahadns.com/1:1.6.7");
//user_pref("network.trr.custom_uri", "https://freedns.controld.com/no-ads-porn-dating-drugs-gambling-malware-typo");
//user_pref("network.trr.uri", "https://freedns.controld.com/no-ads-porn-dating-drugs-gambling-malware-typo");
//user_pref("network.trr.custom_uri", "https://adblock.doh.mullvad.net/dns-query");
//user_pref("network.trr.uri", "https://adblock.doh.mullvad.net/dns-query");
//user_pref("network.trr.custom_uri", "https://dns.adguard.com/dns-query");
//user_pref("network.trr.uri", "https://dns.adguard.com/dns-query");


user_pref("privacy.clearOnShutdown.formdata", false);
user_pref("places.history.enabled", true);
user_pref("privacy.history.custom", true);
user_pref("privacy.sanitize.sanitizeOnShutdown", true);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);
user_pref("privacy.userContext.enabled", true);
user_pref("privacy.userContext.ui.enabled", true);
user_pref("privacy.webrtc.hideGlobalIndicator", true);
user_pref("privacy.webrtc.legacyGlobalIndicator", false);

user_pref("spellchecker.dictionary_path", "/usr/share/hunspell");
user_pref("signon.autofillForms", false);
user_pref("signon.generation.enabled", false);
user_pref("signon.management.page.breach-alerts.enabled", false);
user_pref("signon.rememberSignons", false);

// Allow embedded tweents in Strict ETP mode
user_pref("urlclassifier.trackingSkipURLs", "*.twitter.com, *.twimg.com");
user_pref("urlclassifier.features.socialtracking.skipURLs", "*.twitter.com, *.twimg.com");

// Home > Browsing > Always show scrollbars disable overlay scrollbars
user_pref("widget.gtk.overlay-scrollbars.enabled", true);
