class RemoveBlobFromActiveStorageAttachments < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :active_storage_attachments, :active_storage_blobs
  end
end
