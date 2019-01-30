module Albums
  module CreateAlbum
    class << self
      def call(params)
        album = create_album(params)
        add_user_groups_to_album(album, params.dig(:album, :user_group_ids))
        album
      end

      private

      def create_album(params)
        album_form = AlbumForm.new(Album.new)
        center_id = params[:album][:center_id]
        center_exists = Center.find_by(id: center_id) ? true : false

        if album_form.validate(params[:album]) && center_exists
          album_form.save
          OpenStruct.new(success?: true, model: album_form.model)
        else
          validate_center(album_form, center_id, center_exists)
          OpenStruct.new(success?: false, model: album_form)
        end
      end

      def add_user_groups_to_album(album, user_group_ids)
        if user_group_ids.present?
          album.model.user_groups = sanitized_user_groups(user_group_ids)
        end
      end

      def validate_center(album_form, center_id, center_exists)
        if center_id.present? && !center_exists
          album_form.errors.messages[:center_id] =
            [I18n.t("errors.center.exists")]
        end
      end

      def sanitized_user_groups(user_group_ids)
        UserGroup.where(id: user_group_ids)
      end
    end
  end
end
