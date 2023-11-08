/*global sticky_pref */
// Default Firefox Preferences
//
// Enable magnet protocol support
sticky_pref("network.protocol-handler.expose.magnet", false);

// Disable firefox auto update
sticky_pref("app.update.auto", false);
sticky_pref("app.update.enabled", false);
sticky_pref("app.update.silent", false);

// Default font settings
sticky_pref("font.default.x-unicode", "WenQuanYi Micro Hei");
sticky_pref("font.default.x-western", "WenQuanYi Micro Hei");
sticky_pref("font.default.zh-TW", "WenQuanYi Micro Hei");
sticky_pref("font.default.zh-HK", "WenQuanYi Micro Hei");
sticky_pref("font.default.zh-CN", "WenQuanYi Micro Hei");
sticky_pref("font.default.ja", "WenQuanYi Micro Hei");
sticky_pref("font.default.ko", "WenQuanYi Micro Hei");

sticky_pref("font.name.sans-serif.x-unicode", "WenQuanYi Micro Hei");
sticky_pref("font.name.sans-serif.x-western", "WenQuanYi Micro Hei");
sticky_pref("font.name.sans-serif.zh-TW", "WenQuanYi Micro Hei");
sticky_pref("font.name.sans-serif.zh-HK", "WenQuanYi Micro Hei");
sticky_pref("font.name.sans-serif.zh-CN", "WenQuanYi Micro Hei");
sticky_pref("font.name.sans-serif.ja", "WenQuanYi Micro Hei");
sticky_pref("font.name.sans-serif.ko", "WenQuanYi Micro Hei");

sticky_pref("font.name.serif.x-unicode", "WenQuanYi Micro Hei");
sticky_pref("font.name.serif.x-western", "WenQuanYi Micro Hei");
sticky_pref("font.name.serif.zh-TW", "WenQuanYi Micro Hei");
sticky_pref("font.name.serif.zh-HK", "WenQuanYi Micro Hei");
sticky_pref("font.name.serif.zh-CN", "WenQuanYi Micro Hei");
sticky_pref("font.name.serif.ja", "WenQuanYi Micro Hei");
sticky_pref("font.name.serif.ko", "WenQuanYi Micro Hei");

// Disable sending reports of tab crashes to Mozilla (about:tabcrashed), don't nag user about unsent crash reports
// https://hg.mozilla.org/mozilla-central/file/tip/browser/app/profile/firefox.js
sticky_pref("browser.tabs.crashReporting.sendReport", false);
sticky_pref("browser.crashReports.unsubmittedCheck.enabled", false);

/* 0333a: disable health report ***/
sticky_pref("datareporting.healthreport.uploadEnabled", false);
/* 0333b: disable about:healthreport page (which connects to Mozilla for locale/css+js+json)
 * If you have disabled health reports, then this about page is useless - disable it
 * If you want to see what health data is present, then this must be set at default ***/
sticky_pref("datareporting.healthreport.about.reportUrl", "data:text/plain,");
/* 0334: disable new data submission, master kill switch (FF41+)
 * If disabled, no policy is shown or upload takes place, ever
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1195552 ***/
sticky_pref("datareporting.policy.dataSubmissionEnabled", false);

// Do not check if Firefox is the default browser
sticky_pref("browser.shell.checkDefaultBrowser", false);

// Allow .onion hostnames before passing to the DNS
sticky_pref("network.dns.blockDotOnion", false);

// Send DNS request through SOCKS when SOCKS proxying is in use
// https://trac.torproject.org/projects/tor/wiki/doc/TorifyHOWTO/WebBrowsers
sticky_pref("network.proxy.socks_remote_dns", true);

// Enable auto scroll
sticky_pref("general.autoScroll", true);

// Enable smooth scroll
sticky_pref("general.smoothScroll", true);

// Network
sticky_pref("network.http.pipelining", true);
sticky_pref("network.http.proxy.pipelining", true);
sticky_pref("network.http.speculative-parallel-limit", 0);

sticky_pref("datareporting.healthreport.uploadEnabled", false);

// Stop the generation of Telemetry Pings
sticky_pref("toolkit.telemetry.unified", false);
sticky_pref("toolkit.telemetry.enabled", false);
sticky_pref("toolkit.telemetry.server", "");
sticky_pref("toolkit.telemetry.archive.enabled", false);
sticky_pref("toolkit.telemetry.cachedClientID", "");
sticky_pref("toolkit.telemetry.newProfilePing.enabled", false); // (FF55+)
sticky_pref("toolkit.telemetry.shutdownPingSender.enabled", false); // (FF55+)
sticky_pref("toolkit.telemetry.updatePing.enabled", false); // (FF56+)

sticky_pref("extensions.pocket.enabled", false); // Disable Pocket for Firefox

// Disable WebRTC
sticky_pref("media.peerconnection.enabled", false);
sticky_pref("media.peerconnection.ice.tcp", false);
sticky_pref("media.peerconnection.identity.enabled", false);
sticky_pref("media.peerconnection.identity.timeout", 1);
sticky_pref("media.peerconnection.turn.disable", true);
sticky_pref("media.peerconnection.use_document_iceservers", false);
sticky_pref("media.peerconnection.video.enabled", false);
sticky_pref("media.navigator.enabled", false);
sticky_pref("media.navigator.video.enabled", false);

// 防止 WebRTC 洩漏你的內部網路 IP
sticky_pref("media.peerconnection.ice.default_address_only", true);
sticky_pref("media.peerconnection.ice.no_host", true);

// Disable experiments
sticky_pref("experiments.enabled", false);
sticky_pref("experiments.supported", false);
sticky_pref("experiments.activeExperiment", false);
sticky_pref("experiments.manifest.uri", "");
sticky_pref("network.allow-experiments", false);

sticky_pref("extensions.getAddons.showPane", false);
sticky_pref("extensions.webservice.discoverURL", "");

// Disable web push notifications
sticky_pref("dom.push.enabled", false);

////////////////////////////////////////////////////////////////////////////////
// Extra settings
