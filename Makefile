.DEFAULT_GOAL: new

.PHONY:
new: manual homebrew devtools devfolders casks logins ssh ohmyzsh mackup webdev pythondev email misc backup macossh

.PHONY:
old:
	@echo 'Perform manual steps on old machine, then press <Enter>'
	@echo '-------------------------------------------------------------------'
	@echo '- Connect hard drive'
	@echo '- Back up via time machine'
	@echo '- Wireguard > Manage Tunnels > Export Tunnels to ZIP > hard drive'
	@echo '- OneDrive > Check all files are synced'
	@echo '- Raycast > Export settings to hard drive'
	@echo '- Back up archived / snoozed emails'
	@echo '- Lightroom CC > Develop > Presets > Export as group > hard drive'
	@read
	@echo '-------------------------------------------------------------------'
	mackup backup -f
	cd ~/developer/admin/dotfiles
	git add . ; git commit -m "Update dotfiles" ; git push ; cd
	mackup uninstall
	cp -R ~/.ssh /Volumes/Eric/Organisation/Setup/ssh/
	@echo 'Done!'

.PHONY:
manual:
	@echo 'Perform manual steps on new machine, then press <Enter>'
	@echo '-------------------------------------------------------------------'
	@echo '- Terminal > ⌘ + , > Profiles > Fontsize > 14'
	@echo '- Settings > Keyboard > Input Source > German + English (UK)'
	@echo '- Settings > Trackpad > Point & Click > Tracking speed > one right to middle'
	@echo '- Settings > Accessibility > Pointer Control > Trackpad Options > Enable dragging > three-finger drag'
	@echo '- Settings > Desktop & Dock > Menu Bar > Automatically hide and show the menu bar > Always'
	@echo '- Settings > General > Software Update > Install macOS updates'
	@echo '- Install bitwarden:'
	@echo '   https://apps.apple.com/app/bitwarden/id1352778147'
	@echo '- Install Adobe CC:'
	@echo '   https://www.adobe.com/creativecloud/desktop-app.html'
	@echo '- Install Microsoft Outlook:'
	@echo '   https://apps.apple.com/app/microsoft-outlook/id985367838'
	@echo '- Finder > Sidebar > Untick iCloud and tags'
	@echo '- Install Wireguard, load tunnels from hard drive'
	@echo '   https://apps.apple.com/us/app/wireguard/id1451685025'
	@read

.PHONY:
homebrew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	brew update

.PHONY: devtools
devtools:
	@if xcode-select -p &>/dev/null; then \
		echo "Xcode command line tools are already installed."; \
	else \
		xcode-select --install; \
	fi

.PHONY:
devfolders:
	@if [ ! -d ~/developer/projects ]; then \
		mkdir -p ~/developer/projects; \
		echo "Created directory: ~/developer/projects"; \
	else \
		echo "Directory already exists: ~/developer/projects"; \
	fi

	@if [ ! -d ~/developer/uni ]; then \
		mkdir ~/developer/uni; \
		echo "Created directory: ~/developer/uni"; \
	else \
		echo "Directory already exists: ~/developer/uni"; \
	fi

	@if [ ! -d ~/developer/admin/workspaces ]; then \
		mkdir ~/developer/admin/workspaces; \
		echo "Created directory: ~/developer/admin/workspaces"; \
	else \
		echo "Directory already exists: ~/developer/admin/workspaces"; \
	fi

.PHONY:
casks:
	@echo 'Installing casks'
	brew install --cask anki
	brew install --cask calibre
	brew install --cask dbeaver-community
	brew install --cask dozer
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
	@echo '- Bitwarden'
	@echo '- Adobe CC; then download Lightroom CC and load presets from hard drive'
	@echo '- Anki'
	@echo '- Notion'
	@echo '- OneDrive'
	@echo '- Postman'
	@echo '- Raycast; Raycast > Import Settings & Data from hard drive'
	@echo '- VS Code'
	@echo '- Zotero'
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
	sh -c "$$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	@echo 'Done!'

# TODO: ohmyzsh target terminates

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
	@echo '- Change images (background, profile)'
	@echo '- Configure menu bar with Dozer'

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
