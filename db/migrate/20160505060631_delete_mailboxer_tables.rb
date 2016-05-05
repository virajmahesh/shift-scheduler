class DeleteMailboxerTables < ActiveRecord::Migration
  def change
    drop_table :mailboxer_receipts
    drop_table :mailboxer_conversations
    drop_table :mailboxer_notifications
    drop_table :mailboxer_conversation_opt_outs
  end
end
