# 0.23.3

## Fix

- Fixed `CmsDetailsViewModel` and `CmsEditViewModel` to return the correct result when the item is deleted

# 0.23.2

## Fix

- Primary button on the `CmsEditScreen`

# 0.23.1

## Fix

- Spacing in the `CmsDetailsScreen`

# 0.21.0 - 0.23.0

## Feature

- Added `isDeletable` to `CmsDetailsViewModel` and `CmsEditViewModel`
- Added `onDeleteTapped` to `CmsDetailsViewModel` and `CmsEditViewModel`
- Added `onUpdateTapped` to `CmsDetailsViewModel`

# 0.20.1

## Fix

- Fixed `CmsReferenceModal` to be able to scroll
- Fixed `CmsReferenceModal` to show the search field when `search` is not null

# 0.20.0

## Feature

- BREAKING: Require `impaktfull_ui` version >0.49.0 (breaking changes with ImpaktfullUiPlaceholder)

# 0.19.1

## Fix

- Limit the `impaktfull_ui` dependency to a range between >0.32.0 and <0.48.2

# 0.19.0

## Feature

- Scrollable content in `CmsAddScreen`, `CmsDetailsScreen` and `CmsEditScreen`

# 0.18.4

## Fix

- Fixed `CmsDoubleField` to be able to return the correct value

# 0.18.3

## Fix

- Example updated to use `CmsDoubleField`

# 0.18.2

## Fix

- Fixed `CmsIconField` to be able to return the correct value

# 0.18.0 - 0.18.1

## Feature

- Added `CmsDoubleField`

# 0.17.1

## Fix

- Fixed `CmsImageUrlField.url` to be `CmsImageUrlField`

# 0.17.0

## Feature

- Added `readOnly` to `CmsTextField`

# 0.16.0

## Feature

- Added `CmsImageUrlField`

# 0.15.0

## Feature

- Added `actions` to `CmsListScreen`

# 0.14.0

## Feature

- Added `CmsIconField` and `CmsIconButton`

## Fix

- Make sorting optional on `CmsHeader`

# 0.13.3

## Fix

- Example

# 0.13.1 - 0.13.2

## Fix

- Github pages workflow

# 0.13.0

## Breaking

- Added `context` to all viewmodels so that it is possible to use localization in your CMS

# 0.12.2

## Fix

- impaktfull_architecture dependency updated to use range between >0.8.1 and <1.0.0

# 0.12.1

## Fix

- impaktfull_ui dependency updated to use range between >0.32.0 and <1.0.0

# 0.12.0

## Feature

- Update the `requiredValue` to `isRequired`

## Fix

- Not mounted bugfixes

# 0.11.0

## Feature

- Added support for required fields

# 0.10.0

## Feature

- BREAKING: Changed the get...Field to get... and instantly return the value

# 0.9.0

## Feature

- BREAKING: Renamed `CmsRepo` to `CmsRepository`
- Added `searchQuery` to `CmsRepository`

# 0.8.0

## Feature

- BREAKING: Added `CmsRepo` to `CmsConfig`

# 0.7.0

## Feature

- BREAKING: Added better item loading for `CmsReferenceField`

# 0.6.0

## Feature

- Add `subtitle` to `CmsListScreen`
- Add `onBackTapped` to `CmsListScreen`
- Add `isDrawerEnabled` to `CmsListScreen`

# 0.5.0

## Feature

- Make it possible to use a custom viewmodel for `CmsAddScreen`, `CmsDetailsScreen`, `CmsEditScreen` and `CmsListScreen`

# 0.4.0

## Feature

- Expose the `CmsConfig` in `CmsAddViewModel`, `CmsDetailsViewModel`, `CmsEditViewModel` and `CmsListViewModel`

# 0.3.0

## Feature

- Exposed the `CmsNavigator` in `CmsAddViewModel`, `CmsDetailsViewModel`, `CmsEditViewModel` and `CmsListViewModel`

# 0.2.0

## Feature

- BREAKING: Change `init` to `initCms` in `CmsAddViewModel`, `CmsDetailsViewModel`, `CmsEditViewModel` and `CmsListViewModel`

# 0.1.0

## Feature

- Added support for references using `CmsReferenceField` and `CmsReference`

# 0.0.2

## Fix

- Github actions test

# 0.0.1

## Feature

- Initial release
