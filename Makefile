brew-clean:
	rm Brewfile

brew-save: Brewfile

Brewfile:
	brew bundle dump -f

brew-install:
	brew bundle install

brew-check:
	brew bundle check

stow-install:
	stow --dotfiles --verbose --target ${HOME} .

