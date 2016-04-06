# Wall-Et

## Authors
- Calvin Yau
- Kenneth Lam

## Purpose
Help users become more finanicially responsible and save towards a better future.

## Features
- Bar to show saving progress for items
- Allow input of products for saving goals
- Displays total money currently saved
- Spending and saving statistics
  - Time Statistics: saved in the last week/month/year

## Control Flow
Landing page displays total money saved, top item on goals list, and time statistics

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
