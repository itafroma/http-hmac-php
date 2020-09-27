.PHONY: install clean test coverage update format

install:
	composer install --no-interaction

clean:
	rm -rf vendor/ dist/ composer.lock .php_cs.cache .phpunit.result.cache

test: install format
	./vendor/bin/phpunit
	./vendor/bin/phpmd  src/,test/ text ./phpmd.xml

coverage: install
	phpdbg -qrr ./vendor/bin/phpunit --coverage-clover dist/tests.clover
	./vendor/bin/php-coverage -v --coverage_clover='./dist/tests.clover'

update:
	composer update --no-interaction

format: install
	./vendor/bin/php-cs-fixer fix -v
