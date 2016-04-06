# Wall-Et

## Authors
- Calvin Yau
- Kenneth Lam

## Purpose
Help users become more finanicially responsible and save towards a better 
future.

## Features
- Bar to show saving progress for items
- Allow input of products for saving goals
- Displays total money currently saved
- Spending and saving statistics
  - Time Statistics: saved in the last week/month/year

## Control Flow
- Landing page displays total money saved and items on goals list
- Tap the plus button to add a new item and savings goal
  - Return to the landing page with the new item in the list
- Tap the item and change the amount of money saved for this item
  - Tap save to update and return to landing page
- Tap the statistics button and see the saving and spending statistics view
- Tap on total money saved to alter
  - Tap save to update and return to landing page
- Tap the history button to go to history view

## Implementation

### Model
- ListOfItemsAndSavings.Swift

### View
- MainTableView
  - AdjustSavingsForProducts
- SavingAndSpendingStatisticsView
- AddProductForSavingView
- FinishedProductHistoryView

### Controller
- MainTableViewController
  - AdjustSavingsForProducts
- SavingAndSpendingStatisticsViewController
- AddProductForSavingViewController
- FinishedProductHistoryViewController
