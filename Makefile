.DEFAULT_GOAL: all

.PHONY:
all: manual homebrew devtools devfolders casks logins ssh ohmyzsh mackup webdev pythondev email misc backup macossh

.PHONY:
manual:
	@echo '!! Verify bitwarden password for hard drive still works !!'
	@echo 'Perform manual steps on old machine, then press <Enter>'
	@echo '-------------------------------------------------------------------'
	@echo '1. Back up via time machine'
	@echo '2. Export network settings onto hard drive'
	@echo '3. Export network settings'
	@echo '4. Run `mackup backup -f`''
	@echo '5. Push changes to dotfiles remote repo'
	@echo '6. Run `mackup uninstall`'
	@echo '7. Make sure OneDrive is synced'
	@echo '8. Export lightroom presets to hard drive'
	@echo '9. Wireguard > Manage tunnels > Export to hard drive'
	cp -R ~/.ssh /Volumes/Eric/Organisation/Setup/ssh/
	@read
	@echo 'Perform manual steps on new machine, then press <Enter>'
	@echo '-------------------------------------------------------------------'
	@echo '1. Terminal > ⌘ + , > Profiles > Fontsize > 14'
	@echo '2. Settings > Keyboard > Input Source > German + English (UK)'
	@echo '3. Settings > Trackpad > Point & Click > Tracking speed > one right to middle'
	@echo '4. Settings > Accessibility > Pointer Control > Trackpad Options > Enable dragging > three-finger drag'
	@echo '5. Settings > Desktop & Dock > Menu Bar > Automatically hide and show the menu bar > Always'
	@echo '5. Settings > General > Software Update > Install macOS updates'
	@echo '6. Import network settings'
	@echo '7. Install bitwarden:'
	@echo '   https://apps.apple.com/app/bitwarden/id1352778147'
	@echo '8. Install Adobe CC:'
	@echo '   https://www.adobe.com/creativecloud/desktop-app.html'
	@echo '9. Load lightroom presets from hard drive'
	@echo '10. Change images (background, profile)' # TODO
	@echo 'Finder > Sidebar > Untick iCloud and tags'
	@echo 'Install Wireguard, load tunnels from hard drive'
	@read

.PHONY:
homebrew:
	/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	brew update

.PHONY:
devtools:
	xcode-select --install

.PHONY:
devfolders:
	@echo 'Creating dev folders'
	mkdir -p ~/developer/projects ; mkdir ~/developer/uni ; mkdir ~/developer/admin/workspaces

.PHONY:
casks:
	@echo 'Installing casks'
	brew install --cask anki
	brew install --cask calibre
	brew install --cask dbeaver-community
	brew install --cask dozer
	brew install --cask microsoft-outlook
	brew install --cask notion
	brew install --cask obsidian
	brew install --cask onedrive
	brew install --cask postman
	brew install --cask raycast
	brew install --cask spotify
	brew install --cask visual-studio-code
	brew install --cask zotero

.PHONY:
logins:
	@echo 'Login manually, then press <Enter>'
	@echo '-------------------------------------------------------------------'
	@echo 'Bitwarden'
	@echo 'Adobe CC; then download Lightroom CC)'
	@echo 'Anki'
	@echo 'Notion'
	@echo 'OneDrive'
	@echo 'Postman'
	@echo 'Raycast'
	@echo 'VS Code'
	@echo 'Zotero'
	@read

.PHONY:
ssh:
	@echo 'Connect hard drive, pwd via BitWarden, then press <Enter>'
	@read
	@echo 'Copying SSH keys'
	cp -R /Volumes/Eric/Organisation/Setup/ssh/.ssh ~/.ssh
	chmod 700 ~/.ssh
	chmod 600 ~/.ssh/*

.PHONY:
ohmyzsh:
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

.PHONY:
mackup:
	@echo 'Restoring mackup backup, ssh pwd in BitWarden'
	brew install mackup
	git clone git@github.com:ericjanto/dotfiles.git ~/developer/admin/dotfiles
	cp ~/developer/admin/dotfiles/Mackup/.mackup.cfg ~/.mackup.cfg
	mackup restore
	@echo 'Done!'

.PHONY:
webdev:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | zsh
	nvm install node
	nvm use node
	npm install -g pnpm

.PHONY:
pythondev:
	brew install pyenv
	curl -sSL https://install.python-poetry.org | python3 -
	eval "$(pyenv init -)"

.PHONY:
email:
	@echo 'Login to email accounts, then press <Enter>'
	@read

.PHONY:
misc:
	@echo 'dozer'
	@echo 'dozer'

.PHONY:
backup:
	@echo 'Back up new machine to Time Machine, then press <Enter>'
	@read

.PHONY:
macossh:
	@echo 'Run .macos.sh'
	chmod +x .macos.sh
	sh .macos.sh
	@echo 'Done! Now restart Mac.'
