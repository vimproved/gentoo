# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby31 ruby32 ruby33 ruby34"

RUBY_FAKEGEM_EXTRADOC="README.md History.md"

inherit ruby-fakegem

DESCRIPTION="Hyphenates words according to the rules of the language the word is written in"
HOMEPAGE="https://rubygems.org/gems/text-hyphen"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x64-solaris"
IUSE="test"

ruby_add_bdepend "
	test? (
		>=dev-ruby/hoe-2.8.0
		dev-ruby/test-unit:2
	)"

all_ruby_prepare() {
	sed -i -e '2igem "test-unit", ">= 2.0"' test/test_*.rb || die
}
