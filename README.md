# Wall-Et

## Authors
- Calvin Yau
- Kenneth Lam

## Purpose
Help users become more financially responsible and save towards a better 
future.

## Features
- Allow input of products for saving goals
- Progress Bars to show saving progress for items
- Displays total money currently saved
- Spending and saving statistics
  - Time Statistics: saved in the last week/month/year
- History of completed saving goals

## Control Flow
- Landing page displays total all items on goals list
- Tap the plus button to add a new item to save towards
  - Return to the landing page with the new item in the list
- Tap the item and change the amount of money saved for this item
  - Tap update to change the amount and return to landing page
- Tap the statistics button and see the saving and spending statistics view
- Tap the history button to go to history view

## Implementation

### Model
- CircleBar (progress bar class)

### View
- MainCollectionView
- AdjustSavingsForItemView
- SavingAndSpendingStatisticsView
- AddItemToCollectionView
- FinishedProductHistoryView
- CellView

### Controller
- MainCollectionViewController
- AdjustSavingsForItemViewController
- SavingAndSpendingStatisticsViewController
- AddItemToCollectionViewController
- FinishedProductHistoryViewController
- CellViewController
