{ config, pkgs, inputs, ... }:

{
    programs.firefox = {
        enable = true;
        profiles.seanf = {
            bookmarks = [
                {
                    name = "GitHub";
                    url = "https://github.com/";
                }
            ];

            # See more here: https://github.com/mozilla/policy-templates/blob/master/README.md
            settings = {
                # Tracking protection
                "dom.security.https_only_mode" = true;
                "browser.toolbars.bookmarks.visibility" = "always";
                "browser.startup.homepage.startpage" = "previous-session";
                "browser.sessionstore.resume_session_once" = true;
            };

            search.engines = {
                "Nix Packages" = {
                    urls = [{
                        template = "https://search.nixos.org/packages";
                        params = [
                            { name = "type"; value = "packages"; }
                            { name = "query"; value = "{searchTerms}"; }
                        ];
                    }];

                    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                    definedAliases = [ "nix" ];
                };
            };
            search.default = "DuckDuckGo";
            search.force = true;

            extensions = with inputs.firefox-extensions.packages.${pkgs.system}; [
                bitwarden
                tree-style-tab
                vimium
                gruvbox-dark-theme
            ];
        };
    };
}
